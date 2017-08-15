class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    main_controller = MainMenuViewController.alloc.init
    nav_controller = UINavigationController.alloc.initWithRootViewController(main_controller)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = nav_controller
    @window.makeKeyAndVisible

    true
  end
end
