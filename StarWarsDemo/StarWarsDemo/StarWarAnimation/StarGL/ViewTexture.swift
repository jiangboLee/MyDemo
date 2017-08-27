//
//  ViewTexture.swift
//  StarWarsDemo
//
//  Created by 李江波 on 2017/8/27.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit

class ViewTexture {

    var name: GLuint = 0
    var width: GLsizei = 0
    var height: GLsizei = 0
    
    func setupOpenGL() {
        //用来生成纹理的数量 | textures：存储纹理索引的  
        //glGenTextures就是用来产生你要操作的纹理对象的索引的
        glGenTextures(1, &name)
        //glBindTexture实际上是改变了OpenGL的这个状态，它告诉OpenGL下面对纹理的任何操作都是对它所绑定的纹理对象的，比如glBindTexture(GL_TEXTURE_2D,1)告诉OpenGL下面代码中对2D纹理的任何设置都是针对索引为1的纹理的。
        glBindTexture(GLenum(GL_TEXTURE_2D), name)
        //glTexParmeteri()函数来确定如何把图象从纹理图象空间映射到帧缓冲图象空间(如：映射时为了避免多边形上的图像失真，而重新构造纹理图像等)。
        //GL_TEXTURE_MIN_FILTER: 缩小过滤
        //GL_LINEAR: 线性过滤, 使用距离当前渲染像素中心最近的4个纹素加权平均值.
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MIN_FILTER), GLint(GL_LINEAR))
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MAG_FILTER), GLint(GL_LINEAR))
        //GL_TEXTURE_WRAP_S: S方向上的贴图模式.
        //GL_CLAMP: 将纹理坐标限制在0.0,1.0的范围之内.如果超出了会如何呢.不会错误,只是会边缘拉伸填充.
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_S), GLint(GL_CLAMP_TO_EDGE))
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_T), GLint(GL_CLAMP_TO_EDGE))
        glBindTexture(GLenum(GL_TEXTURE_2D), 0)
    }
    
    func render(view: UIView) {
        let scale = UIScreen.main.scale
        width = GLsizei(view.layer.bounds.size.width * scale)
        height = GLsizei(view.layer.bounds.size.height * scale)
        //repeatElement 重复
        var texturePixelBuffer = [GLubyte](repeatElement(0, count: Int(height * width * 4)))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        withUnsafeMutablePointer(to: &texturePixelBuffer[0]) { texturePixelBuffer in
            let context = CGContext(data: texturePixelBuffer, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: Int(width * 4), space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue)!
            context.scaleBy(x: scale, y: scale)
            
            UIGraphicsPushContext(context)
            view.drawHierarchy(in: view.layer.bounds, afterScreenUpdates: false)
            UIGraphicsPopContext()
            
            glBindTexture(GLenum(GL_TEXTURE_2D), name)
            
            glTexImage2D(GLenum(GL_TEXTURE_2D), 0, GLint(GL_RGBA), width, height, 0, GLenum(GL_RGBA), GLenum(GL_UNSIGNED_BYTE), texturePixelBuffer)
            glBindTexture(GLenum(GL_TEXTURE_2D), 0)
        }
    }
    
    deinit {
        if name != 0 {
            glDeleteTextures(1, &name)
        }
    }
}


