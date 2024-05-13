import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:esalesapp/widgets/showdialoghapus_widget.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcrud_bloc.dart';
import 'package:esalesapp/pages/jobreal/jobrealcari_tile_widget.dart';

class JobRealCariListWidget extends StatefulWidget {
	final String searchText;
	const JobRealCariListWidget({super.key, required this.searchText});

	@override
	JobRealCariListWidgetState createState() => JobRealCariListWidgetState();
}

class JobRealCariListWidgetState extends State<JobRealCariListWidget> {
	late JobRealCariBloc jobRealCariBloc;
	late JobRealCrudBloc jobRealCrudBloc;
	final ScrollController _scrollController = ScrollController();

	@override
	void initState() {
		super.initState();
		_scrollController.addListener(_onScroll);
	}

	@override
	void dispose() {
		_scrollController
			..removeListener(_onScroll)
			..dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		jobRealCariBloc = BlocProvider.of<JobRealCariBloc>(context);
		jobRealCrudBloc = BlocProvider.of<JobRealCrudBloc>(context);
		return BlocConsumer<JobRealCariBloc, JobRealCariState>(
			builder: (context, state) {
			if (state.status == ListStatus.success) {
			return state.items.isNotEmpty
				? Flexible(
					child: ListView.builder(
						padding: EdgeInsets.zero,
						controller: _scrollController,
						itemCount: state.items.length,
						itemBuilder: (_, index) => Container(
							margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
							padding: const EdgeInsets.all(0.2),
							decoration: BoxDecoration(
								borderRadius: BorderRadius.circular(15.0)),
							child: Column(
								children: <Widget>[
									Slidable(
										endActionPane: ActionPane(
											motion: const BehindMotion(),
												children: [
													SlidableAction(
														onPressed: (context) {
															jobRealCariBloc.add(
																UbahJobRealCariEvent(
																	recordId: state
																		.items[index]
																		.jobreal1Id));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].jobreal1Id);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: JobRealCariTileWidget(
												catName: state.items[index].catName??'',
												hasil: state.items[index].hasil,
												jobNama: state.items[index].jobNama??'',
												jobreal1Id: state.items[index].jobreal1Id,
												materi: state.items[index].materi,
												mediaNama: state.items[index].mediaNama??'',
												picName: state.items[index].picName,
												realJam: state.items[index].realJam,
												realTgl: state.items[index].realTgl,
											)),
							],
						),
					)),
				)
			: const Center(
				child: Padding(
					padding: EdgeInsets.only(top: 80.0),
					child: Text(
						'No Data Available!!',
						style: TextStyle(
							color: Colors.red,
							fontSize: 12.0,
							fontWeight: FontWeight.bold),
					),
				),
			);
		} else {
			return const Center(
					child: Text(
						'No Data Available!!',
						style: TextStyle(
							color: Colors.red,
							fontSize: 12.0,
							fontWeight: FontWeight.bold),
					),
				);
			}
			}, buildWhen: (previous, current) {
				return (current.status == ListStatus.success);
			}, listener: (context, state) {}
		);
	}
	void _onScroll() {
		if (!_scrollController.hasClients) return;
		if (_scrollController.position.pixels ==
				_scrollController.position.maxScrollExtent) {
			jobRealCariBloc.add(FetchJobRealCariEvent(
				searchText: widget.searchText, hal: jobRealCariBloc.state.hal));
		}
	}

	onHapusFunction(String recordId) {
		jobRealCrudBloc.add(JobRealCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			jobRealCariBloc.add(CloseDialogJobRealCariEvent());
		});
	}

}