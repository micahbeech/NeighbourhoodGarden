//
//  AddListingView.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-08.
//

import SwiftUI

// MARK: ViewState

extension AddListingView {
    struct ViewState: DefaultIdentifiable {}

    enum ViewEvent {
        case addListing(String, String, String)
    }
}

// MARK: View

struct AddListingView: View {
    typealias ViewModel = AnyViewModel<ViewState, ViewEvent>
    @ObservedInject private var viewModel: ViewModel
    @State private var name = ""
    @State private var description = ""
    @State private var price = ""
    let onAdd: () -> Void

    var body: some View {
        Form {
            Section(header: Text("Product Name").secondaryStyle()) {
                TextField("Name", text: $name)
                    .font(.avenirMedium(.medium))
                    .foregroundColor(.gardenPrimarylabel)
            }

            Section(header: Text("Description").secondaryStyle()) {
                TextEditor(text: $description)
                    .font(.avenirMedium(.medium))
                    .foregroundColor(.gardenPrimarylabel)
            }

            Section(header: Text("Price").secondaryStyle()) {
                TextField("$0.00", text: $price)
                    .keyboardType(.decimalPad)
                    .font(.avenirMedium(.medium))
                    .foregroundColor(.gardenPrimarylabel)
            }

            Button {
                viewModel.trigger(.addListing(name, description, price))
                onAdd()
            } label: {
                HStack {
                    Spacer()
                    Text("Create")
                        .primaryStyle()
                    Spacer()
                }
            }
        }
    }
}

// MARK: Previews

struct AddListingView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            AddListingView(onAdd: {})
                .injectPreview(AddListingView.ViewModel.self)
        }
    }
}

extension AddListingView.ViewState: StatePreviewable {
    static let preview = Self()
}
