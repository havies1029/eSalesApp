import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combojobgroup_model.dart';
import 'package:esalesapp/repositories/combobox/combojobgroup_repository.dart';

DropdownSearch<ComboJobGroupModel> buildFieldComboJobGroup({
	required String labelText,
	GlobalKey<DropdownSearchState<ComboJobGroupModel>>? comboKey,
	ComboJobGroupModel? initItem,
	Function(ComboJobGroupModel?)? onChangedCallback,
	required Function(ComboJobGroupModel?) onSaveCallback,
	Function(ComboJobGroupModel?)? validatorCallback
	}) {
	return DropdownSearch<ComboJobGroupModel>(
		key: comboKey,
		selectedItem: initItem,
		dropdownDecoratorProps: DropDownDecoratorProps(
			dropdownSearchDecoration: InputDecoration(
				hintText: '...',
				labelText: labelText,
			),
		),
			asyncItems: (String filter) async {
				return ComboJobGroupRepository().getComboJobGroup();
			},
			clearButtonProps: const ClearButtonProps(isVisible: true),
			popupProps: const PopupPropsMultiSelection.modalBottomSheet(
				isFilterOnline: false,
				showSelectedItems: true,
				showSearchBox: false,
				itemBuilder: itemBuilderComboJobGroup,
			),
			compareFn: (item, sItem) => item.mjobgroupId == sItem.mjobgroupId,
			itemAsString: (item) {
				return item.groupName;
			},
			onChanged: (value) {
				if (onChangedCallback != null) {
					onChangedCallback(value);
				}
			},
			onSaved: (value) {
				onSaveCallback(value);
			},
			validator: (value) {
				if (validatorCallback != null) {
					validatorCallback(value);
					if (value == null) {
						return "";
					}
				}
				return null;
			},
		);
}

Widget itemBuilderComboJobGroup(
	BuildContext context, ComboJobGroupModel item, bool isSelected) {
	return Container(
		margin: const EdgeInsets.symmetric(horizontal: 8),
		decoration: !isSelected
			? null
			: BoxDecoration(
				border: Border.all(color: Theme.of(context).primaryColor),
				borderRadius: BorderRadius.circular(5),
				color: Colors.white,
			),
		child: ListTile(
			selected: isSelected,
			title: Text(item.groupName),
		),
	);
}
