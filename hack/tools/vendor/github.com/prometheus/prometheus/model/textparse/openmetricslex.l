%{
// Copyright 2018 The Prometheus Authors
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package textparse

import (
    "fmt"
)

// Lex is called by the parser generated by "go tool yacc" to obtain each
// token. The method is opened before the matching rules block and closed at
// the end of the file.
func (l *openMetricsLexer) Lex() token {
    if l.i >= len(l.b) {
        return tEOF
    }
    c := l.b[l.i]
    l.start = l.i

%}

D     [0-9]
L     [a-zA-Z_]
M     [a-zA-Z_:]
C     [^\n]
S     [ ]

%x sComment sMeta1 sMeta2 sLabels sLValue sValue sTimestamp sExemplar sEValue sETimestamp

%yyc c
%yyn c = l.next()
%yyt l.state


%%

#{S}                                  l.state = sComment
<sComment>HELP{S}                     l.state = sMeta1; return tHelp
<sComment>TYPE{S}                     l.state = sMeta1; return tType
<sComment>UNIT{S}                     l.state = sMeta1; return tUnit
<sComment>"EOF"\n?                    l.state = sInit; return tEOFWord
<sMeta1>{M}({M}|{D})*                 l.state = sMeta2; return tMName
<sMeta2>{S}{C}*\n                     l.state = sInit; return tText

{M}({M}|{D})*                         l.state = sValue; return tMName
<sValue>\{                            l.state = sLabels; return tBraceOpen
<sLabels>{L}({L}|{D})*                return tLName
<sLabels>\}                           l.state = sValue; return tBraceClose
<sLabels>=                            l.state = sLValue; return tEqual
<sLabels>,                            return tComma
<sLValue>\"(\\.|[^\\"\n])*\"          l.state = sLabels; return tLValue
<sValue>{S}[^ \n]+                    l.state = sTimestamp; return tValue
<sTimestamp>{S}[^ \n]+                return tTimestamp
<sTimestamp>\n                        l.state = sInit; return tLinebreak
<sTimestamp>{S}#{S}\{                 l.state = sExemplar; return tComment

<sExemplar>{L}({L}|{D})*              return tLName
<sExemplar>\}                         l.state = sEValue; return tBraceClose
<sExemplar>=                          l.state = sEValue; return tEqual
<sEValue>\"(\\.|[^\\"\n])*\"          l.state = sExemplar; return tLValue
<sExemplar>,                          return tComma
<sEValue>{S}[^ \n]+                   l.state = sETimestamp; return tValue
<sETimestamp>{S}[^ \n]+               return tTimestamp
<sETimestamp>\n                       l.state = sInit; return tLinebreak

%%

    return tInvalid
}