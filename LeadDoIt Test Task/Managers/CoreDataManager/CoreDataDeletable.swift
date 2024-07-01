import Foundation

protocol ICoreDataDeletable {
    func load() -> [FilterOptions]
    func delete(filterOptions: FilterOptions)
}
