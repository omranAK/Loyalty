import '../../constant/imports.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    List<NotificationModel> notificationsList = [];

    return BlocProvider(
      create: (context) => NotificationsBloc(
        NotificationsRepository(
          externalService: ExternalService(),
        ),
      )..add(
          LoadNotificationEvent(),
        ),
      child: Scaffold(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        appBar: AppBar(
          actions: [
            BlocBuilder<NotificationsBloc, NotificationsState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    BlocProvider.of<NotificationsBloc>(context, listen: false)
                        .add(LoadNotificationEvent());
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                );
              },
            )
          ],
          title: Text(
            localizations!.notifications,
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.appBarColor,
        ),
        body: BlocConsumer<NotificationsBloc, NotificationsState>(
          listener: (context, state) {
            if (state is NotificationsLoaddedState) {
              notificationsList = state.notificationsList;
            }
          },
          builder: (context, state) {
            if (state is NotificationsLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).badgeTheme.backgroundColor,
                ),
              );
            } else if (state is NotificationsFailedState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      localizations.somthingwentwrong,
                      style: GoogleFonts.montserrat(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.restart_alt_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        BlocProvider.of<NotificationsBloc>(context)
                            .add(LoadNotificationEvent());
                      },
                      label: Text(
                        localizations.regetdata,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return notificationsList.isEmpty
                  ? Center(
                      child: Builder(builder: (context) {
                        return Text(
                          localizations.youhavenonotifications,
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      }),
                    )
                  : ListView.builder(
                      itemCount: notificationsList.length,
                      itemBuilder: (context, index) => NotificationItem(
                        notification: notificationsList[index],
                      ),
                    );
            }
          },
        ),
      ),
    );
  }
}
