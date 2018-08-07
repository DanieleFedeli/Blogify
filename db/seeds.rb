# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.take
10.times do
  user.pending_posts.create! title: 'Titolo',
  
  body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus vestibulum aliquam orci, sed aliquet nulla placerat quis. Nunc id libero eu sapien tempus placerat eu vitae lacus. Cras gravida turpis eget nulla iaculis tempus. Pellentesque vitae egestas nunc, quis consequat neque. Vivamus porta sodales elementum. Nullam ullamcorper sed nulla in blandit. Donec in nisi at nunc ullamcorper mollis et a nunc. Nullam at sodales mauris. Donec blandit enim id consectetur varius. Suspendisse condimentum nibh at porta finibus. Aliquam aliquam ipsum quis ex semper mollis. Nam porttitor, quam et tincidunt dapibus, massa diam iaculis lacus, et facilisis elit nisl nec orci. Nunc turpis lectus, sollicitudin nec tellus vel, molestie efficitur tellus.

  Nam tortor odio, scelerisque sed elementum sed, laoreet volutpat quam. Maecenas ac tincidunt sem. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Ut nec justo ut justo congue varius at at diam. Praesent id quam sit amet odio hendrerit fringilla. Pellentesque mattis interdum erat, a tincidunt turpis blandit semper. Curabitur ultrices nunc eget lobortis molestie. Nulla viverra turpis tempor tincidunt egestas. Nullam aliquet libero quis egestas consequat. Quisque vestibulum tortor arcu, a iaculis justo feugiat non. Proin vel augue diam. Sed finibus est quis leo aliquet, ac tincidunt purus suscipit. Curabitur faucibus massa nec enim mollis, nec feugiat sapien lobortis. Maecenas sed dapibus risus, in dignissim dolor. Nullam ut commodo elit.
  
  Maecenas efficitur diam risus, vulputate tempor sem facilisis in. Sed lobortis ornare convallis. Ut pretium dictum sapien sit amet auctor. Cras non sagittis augue. Mauris sagittis scelerisque maximus. Etiam iaculis enim odio, at bibendum nibh luctus ut. Curabitur ornare mi ac molestie gravida. Maecenas in nunc luctus, suscipit sem sit amet, tempor tellus.
  
  Maecenas mollis velit quis lectus blandit, sit amet tempor tellus tristique. In congue justo massa, ac finibus lorem semper ut. Curabitur rutrum nunc eleifend massa eleifend, sit amet congue lacus sagittis. Nam consequat, dolor et fermentum efficitur, mi felis pulvinar nibh, ac rutrum turpis odio in nisi. Nullam finibus felis sit amet odio ultricies, et bibendum tortor mollis. Quisque sed erat odio. Proin quis gravida neque, vitae efficitur justo. Phasellus hendrerit consectetur lectus, a varius nibh posuere in. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec commodo ante dolor, a ornare enim consectetur vitae. Vestibulum nec sapien odio.
  
  Phasellus eu nibh non elit pretium eleifend. Duis ultrices lectus sed enim rutrum congue. Quisque vitae orci ullamcorper, dapibus sem et, congue tellus. Nullam orci libero, laoreet ut arcu sed, sagittis dapibus metus. Aliquam posuere felis ac faucibus lacinia. Ut faucibus nisi et hendrerit dignissim. Fusce sollicitudin, dui vitae imperdiet molestie, arcu velit lobortis elit, semper cursus dolor elit in ipsum. Fusce dictum congue nunc, ut ullamcorper lorem finibus eget. Nam tempus vestibulum condimentum. Morbi vel mauris magna.'

end