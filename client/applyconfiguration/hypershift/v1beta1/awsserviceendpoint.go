/*


Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
// Code generated by applyconfiguration-gen. DO NOT EDIT.

package v1beta1

// AWSServiceEndpointApplyConfiguration represents an declarative configuration of the AWSServiceEndpoint type for use
// with apply.
type AWSServiceEndpointApplyConfiguration struct {
	Name *string `json:"name,omitempty"`
	URL  *string `json:"url,omitempty"`
}

// AWSServiceEndpointApplyConfiguration constructs an declarative configuration of the AWSServiceEndpoint type for use with
// apply.
func AWSServiceEndpoint() *AWSServiceEndpointApplyConfiguration {
	return &AWSServiceEndpointApplyConfiguration{}
}

// WithName sets the Name field in the declarative configuration to the given value
// and returns the receiver, so that objects can be built by chaining "With" function invocations.
// If called multiple times, the Name field is set to the value of the last call.
func (b *AWSServiceEndpointApplyConfiguration) WithName(value string) *AWSServiceEndpointApplyConfiguration {
	b.Name = &value
	return b
}

// WithURL sets the URL field in the declarative configuration to the given value
// and returns the receiver, so that objects can be built by chaining "With" function invocations.
// If called multiple times, the URL field is set to the value of the last call.
func (b *AWSServiceEndpointApplyConfiguration) WithURL(value string) *AWSServiceEndpointApplyConfiguration {
	b.URL = &value
	return b
}