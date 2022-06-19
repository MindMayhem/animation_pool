# Animation Pool

***animation_pool*** is a package that allows you to implement a pool of reused animations, without recreating them


## Preview GIFs
![screen-20220619-034009 (online-video-cutter com)](https://user-images.githubusercontent.com/39557395/174461464-9fb24c82-56df-4ebf-b9b5-d5c5a873271b.gif)
![screen-20220619-034206 (online-video-cutter com)](https://user-images.githubusercontent.com/39557395/174461469-7a1c02ce-5eeb-4299-b306-0dcafe42607b.gif)


## Components

The main component is ***AnimationPoolScope***, which contains a mechanism for caching and "lazy" loading of AnimationControllers.

```dart
AnimationPoolScope(
        tickerProvider: this, // Should be passed from TickerProviderStateMixin
        maxAnimCount: (int), // Limitation for instancing new AnimationControllers
        duration: const Duration(milliseconds: 350), // Default duration (optional)
        child: (Widget))
```

It has two public methods:

**getFromPool(context, index)** - Returns _AnimationController_ from list of active controllers where context is the context containing this _AnimationPoolScope_, and index is the sequence number of the animatable object (e.g item index in ListView/SliverList)

**disposeControllers(context)** - Will give the dispose command to all used animationcontrollers, it must be applied if the current screen is going to be replaced

## Usage

Keep it in the mind that this is Inherited Widget, so, it can be passed upper in widget tree, not only above widget that using pool, but for best practice and avoiding troubles always place it above widget with that you using it.

***Example usage of Animation Pool:***

```dart
AnimationPoolScope(
        tickerProvider: this,   // Should be passed from TickerProviderStateMixin
        maxAnimCount: 14,       // Limitation for instancing new AnimationControllers
        duration: const Duration(milliseconds: 350),    // Default duration (optional)
        child: ListView.builder(
            itemBuilder: (context, index) => ScaleTransition(
                scale: AnimationPoolScope.getFromPool(context, index),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .7,
                    height: 50,
                    color: Colors.blueAccent,
                  ),
                )),
          ),
        )
```



## Post Scriptum

The package is not fully ready yet, sequential animation of widgets is planned within a limited number of AnimationController's

*Gladly appreciate for any feedback and pull requests on Github*
