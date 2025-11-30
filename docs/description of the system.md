# Description of the system

This is a comprehensive system for managing and deploying nix-based configurations across a variety of architectures and environments. It is designed to be modular, extensible, and adaptable to different use cases, including using vintage architectures, current architectures, virtual machines, and hardware virtualization in infrastructure, home labs, personal computing, and edge devices.

It will support building on higher capacity machines and deploying to lower capacity machines, as well as cross-compiling for different architectures. The system will also support various deployment models, including single-node deployments, multi-node constellations, heterogeneous community or fleet deployments, and deployments within private or obfuscated networks.

## Targets

Vintage Architectures (x86, arm, riscv, mips, sparc, ppc, motorola)

Current Architectures (x86_64, arm64, risc64)

Virtual Machines (JVM, BEAM, WASM, eBPF, V8)

Hardware Virtualization (OCI/CRI, QEMU/KVM,libvirt)

### base

The base image is a minimal OS image that contains the interoperability hooks for all the rest of the builds. It is the foundation of all other images and is used to build the other images but is not used alone to run any services.

### base-pet

The base-pet image is a OS image used to create "Pets" which are long-lived, manually managed servers. It includes various quality of life tools and configurations that make it easier to manage and maintain the server, perform hands-on system administration from the command line or using a web-based management tool.

### base-livestock

The base-livestock image is a OS image used to create "Livestock" which are automatically managed servers. It includes various tools and configurations which make it easier to automate the management and maintenance of a headless server.

### base-mascot

The base-mascot image is a OS image used to create "Mascots" which are automatically managed servers that are used to run a containers. It includes various tools and configurations which make it easier to automate the management and maintenance of a container server and the containers it hosts.

## Deployments

### nodes

A node is the basic unit of deployment.  It is a single instance of software than can be built against one or more target architectures and deployed into infrastructure to use compute, storage, and connectivity resources there.  

### clusters

A cluster is a group of nodes that work together to provide a distributed application deployment.  Clusters are normally homogeneous (all nodes are the same). Heterogeneous (nodes are different) clusters are possible, but often it's easier to deploy the same machines as constellations.  Clusters may also be deployed into multiple infrastructure locations to achieve distributed resiliency.

### constellation

A constellation is a group of nodes that represent a distributed application deployment. Every constellation node contains the undernet sub-system and the deploy-time configuration of that undernet is shared among all nodes in the constellation.  Constellations may be deployed into multiple infrastructure locations to achieve distributed resiliency.

### community

A community is the set of nodes that share the same infrastructure, but are not necessarily part of the same constellation.  

### fleet

A fleet is the set of all nodes managed by a single administrative domain.  A fleet may contain multiple communities and constellations.

## Sub-Systems

### undernet sub-system

The undernet sub-system is a set of components that provide the core functionality of the undernet. It includes the mpvpn, zero-trust network authentication, application layer routing, service registration and discovery, the distributed file system, and the undernet API.

### peer-to-peer sub-system

The peer-to-peer sub-system is a set of components that provide the core functionality of the peer-to-peer network. It includes the peer-to-peer mesh router, the route-distribution services, and the p2p API.

### federation sub-system

The federation sub-system is a set of components that provide the core functionality of the federation network. It includes the federation services for conversing and publishing, their distributed storage solutions, and the federation API.
