//
//  CourseVideoTableViewCellModel.swift
//  LearnConnect
//
//  Created by Melih Avcı on 27.11.2024.
//

import Foundation

public protocol CourseVideoTableViewCellModelDataSource: AnyObject {
    var videoName: String { get }
}

public protocol CourseVideoTableViewCellModelEventSource: AnyObject { }

public protocol CourseVideoTableViewCellModelProtocol: CourseVideoTableViewCellModelDataSource, CourseVideoTableViewCellModelEventSource { }

public class CourseVideoTableViewCellModel: CourseVideoTableViewCellModelProtocol {

    public var videoName: String

    public init(videoName: String) {
        self.videoName = videoName
    }
}
