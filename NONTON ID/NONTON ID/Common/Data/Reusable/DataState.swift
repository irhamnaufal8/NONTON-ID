//
//  DataState.swift
//  NONTON ID
//
//  Created by Irham Naufal on 11/03/24.
//

import SwiftUI

enum DataState<Value>: Identifiable {
    case initial
    case loading
    case hasData(Value)
    case error(Error)
    
    internal var id: UUID { UUID() }
}

extension DataState {
    var value: Value? {
        if case .hasData(let value) = self {
            return value
        }
        
        return nil
    }
    
    var error: Error? {
        if case .error(let error) = self {
            return error
        }
        return nil
    }
}

extension DataState: Equatable {
    static func == (lhs: DataState<Value>, rhs: DataState<Value>) -> Bool {
        lhs.id == rhs.id
    }
}

extension ObservableObject {
    func binding<Value, Field>(
        _ keyPath: ReferenceWritableKeyPath<Self, DataState<Value>>,
        for fieldKeyPath: WritableKeyPath<Value, Field>,
        defaultValue: Field
    ) -> Binding<Field> where Field: Equatable {
        Binding<Field>(
            get: {
                if case .hasData(let value) = self[keyPath: keyPath] {
                    return value[keyPath: fieldKeyPath]
                }
                return defaultValue
            },
            set: { newValue in
                var currentState = self[keyPath: keyPath]
                switch currentState {
                case .hasData(var value):
                    value[keyPath: fieldKeyPath] = newValue
                    currentState = .hasData(value)
                default:
                    break
                }
                self[keyPath: keyPath] = currentState
            }
        )
    }
    
    func binding<Value, Field>(
        _ keyPath: ReferenceWritableKeyPath<Self, DataState<Value>>,
        for fieldKeyPath: WritableKeyPath<Value, Field?>,
        defaultValue: Field
    ) -> Binding<Field> where Value: Equatable, Field: Equatable {
        Binding<Field>(
            get: {
                if case .hasData(let value) = self[keyPath: keyPath] {
                    return value[keyPath: fieldKeyPath] ?? defaultValue
                }
                return defaultValue
            },
            set: { newValue in
                var currentState = self[keyPath: keyPath]
                switch currentState {
                case .hasData(var value):
                    value[keyPath: fieldKeyPath] = newValue
                    currentState = .hasData(value)
                default:
                    break
                }
                self[keyPath: keyPath] = currentState
            }
        )
    }
    
    func binding<Object, Field>(
        _ objectKeyPath: ReferenceWritableKeyPath<Self, DataState<Object>>,
        for fieldPath: @escaping (Object) -> Field?,
        setField: @escaping (inout Object, Field?) -> Void,
        defaultValue: Field
    ) -> Binding<Field> where Object: Equatable, Field: Equatable {
        Binding<Field>(
            get: {
                if case .hasData(let object) = self[keyPath: objectKeyPath] {
                    return fieldPath(object) ?? defaultValue
                }
                return defaultValue
            },
            set: { newValue in
                var currentState = self[keyPath: objectKeyPath]
                if case .hasData(var object) = currentState {
                    setField(&object, newValue)
                    currentState = .hasData(object)
                    self[keyPath: objectKeyPath] = currentState
                }
            }
        )
    }
    
    func binding<T>(
        at index: Int,
        in keyPath: ReferenceWritableKeyPath<Self, DataState<[T]>>
    ) -> Binding<T?> where T: Equatable {
        Binding<T?>(
            get: {
                if case .hasData(let array) = self[keyPath: keyPath] {
                    return array.indices.contains(index) ? array[index] : nil
                }
                return nil
            },
            set: { newValue in
                guard let newValue = newValue else { return }
                var currentState = self[keyPath: keyPath]
                switch currentState {
                case .hasData(var array):
                    if array.indices.contains(index) {
                        array[index] = newValue
                        currentState = .hasData(array)
                    }
                default: break
                }
                self[keyPath: keyPath] = currentState
            }
        )
    }
}
