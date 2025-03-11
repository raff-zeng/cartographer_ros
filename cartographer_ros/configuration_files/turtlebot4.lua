include "map_builder.lua"
include "trajectory_builder.lua"

options = {
  map_builder = MAP_BUILDER,  -- 地图构建器
  trajectory_builder = TRAJECTORY_BUILDER,  -- 轨迹构建器
  map_frame = "map",  -- 地图坐标系
  tracking_frame = "imu_link",  -- 追踪坐标系
  published_frame = "base_link",  -- 发布坐标系
  odom_frame = "odom",  -- 里程计坐标系
  provide_odom_frame = true,  -- 是否提供里程计坐标系
  publish_frame_projected_to_2d = true,  -- 是否发布投影到2D的坐标系
  use_pose_extrapolator = true,  -- 是否使用位姿外推器

  -- 传感器配置
  use_odometry = true,  -- 是否使用里程计
  -- use_imu_data = true,  -- 是否使用IMU数据
  use_nav_sat = false,  -- 是否使用导航卫星
  use_landmarks = false,  -- 是否使用地标
  num_laser_scans = 1,  -- 激光扫描数量
  num_point_clouds = 0,  -- 点云数量
  num_multi_echo_laser_scans = 0,  -- 多回波激光扫描数量
  num_subdivisions_per_laser_scan = 1,  -- 每个激光扫描的子分区数量

  -- 时间配置
  lookup_transform_timeout_sec = 0.5,  -- 查找变换超时时间（秒）
  submap_publish_period_sec = 0.3,  -- 子地图发布周期（秒）
  pose_publish_period_sec = 5e-3,  -- 位姿发布周期（秒）
  trajectory_publish_period_sec = 30e-3,  -- 轨迹发布周期（秒）

  -- 采样率配置
  rangefinder_sampling_ratio = 1.,  -- 测距仪采样率
  odometry_sampling_ratio = 1.,  -- 里程计采样率
  fixed_frame_pose_sampling_ratio = 1.,  -- 固定坐标系位姿采样率
  imu_sampling_ratio = 1.,  -- IMU采样率
  landmarks_sampling_ratio = 1.,  -- landmarks采样率
}

MAP_BUILDER.use_trajectory_builder_2d = true  -- 使用2D轨迹构建器

-- 2D SLAM参数
TRAJECTORY_BUILDER_2D.min_range = 0.12  -- 最小范围
TRAJECTORY_BUILDER_2D.max_range = 3.5  -- 最大范围
TRAJECTORY_BUILDER_2D.missing_data_ray_length = 3.  -- 缺失数据射线长度
TRAJECTORY_BUILDER_2D.use_imu_data = true  -- 使用IMU数据
TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching = true  -- 使用在线相关扫描匹配
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.linear_search_window = 0.15  -- 实时相关扫描匹配器线性搜索窗口
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.translation_delta_cost_weight = 10.  -- 平移增量代价权重
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.rotation_delta_cost_weight = 1e-1  -- 旋转增量代价权重
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.occupied_space_weight = 1.0
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.translation_weight = 10.0
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.rotation_weight = 40.0

-- 闭环检测参数
POSE_GRAPH.constraint_builder.min_score = 0.65
POSE_GRAPH.constraint_builder.global_localization_min_score = 0.7
POSE_GRAPH.optimization_problem.local_slam_pose_translation_weight = 1e5
POSE_GRAPH.optimization_problem.local_slam_pose_rotation_weight = 1e5
POSE_GRAPH.optimization_problem.odometry_translation_weight = 1e5
POSE_GRAPH.optimization_problem.odometry_rotation_weight = 1e5

return options