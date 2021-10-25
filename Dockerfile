#
#	MetaCall Core Alpine Example by Parra Studios
#	An example for building MetaCall in Alpine.
#
#	Copyright (C) 2016 - 2020 Vicente Eduardo Ferrer Garcia <vic798@gmail.com>
#
#	Licensed under the Apache License, Version 2.0 (the "License");
#	you may not use this file except in compliance with the License.
#	You may obtain a copy of the License at
#
#		http://www.apache.org/licenses/LICENSE-2.0
#
#	Unless required by applicable law or agreed to in writing, software
#	distributed under the License is distributed on an "AS IS" BASIS,
#	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#	See the License for the specific language governing permissions and
#	limitations under the License.
#

FROM alpine:3.13.6

# Image descriptor
LABEL copyright.name="Vicente Eduardo Ferrer Garcia" \
	copyright.address="vic798@gmail.com" \
	maintainer.name="Vicente Eduardo Ferrer Garcia" \
	maintainer.address="vic798@gmail.com" \
	vendor="MetaCall Inc." \
	version="0.1"

# Install dependencies
RUN apk update \
	&& apk add git build-base linux-headers cmake nodejs python3-dev

# Set working directory to home
WORKDIR /root

# Clone and build the project
RUN ln -s /usr/bin/python3 /usr/bin/python \
	&& ln -s /usr/bin/pip3 /usr/bin/pip \
	&& git clone --branch v0.5.8 https://github.com/metacall/core \
	&& mkdir core/build && cd core/build \
	&& cmake \
		-DNODEJS_CMAKE_DEBUG=On \
		-DOPTION_BUILD_LOADERS_PY=On \
		-DOPTION_BUILD_LOADERS_NODE=On \
		-DOPTION_BUILD_LOADERS_TS=On \
		-DOPTION_BUILD_PORTS=Off \
		-DOPTION_BUILD_DETOURS=Off \
		-DOPTION_BUILD_SCRIPTS=Off \
		-DOPTION_BUILD_TESTS=Off \
		-DOPTION_BUILD_EXAMPLES=Off \
		-DOPTION_BUILD_BACKTRACE=Off \
		.. \
	&& cmake --build . --target install
