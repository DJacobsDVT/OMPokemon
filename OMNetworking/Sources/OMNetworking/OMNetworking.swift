// The Swift Programming Language
// https://docs.swift.org/swift-book

import Factory

extension Container {
    var baseService: Factory<BaseService> {
        Factory(self) {
            BaseServiceImpl()
        }
    }
}
