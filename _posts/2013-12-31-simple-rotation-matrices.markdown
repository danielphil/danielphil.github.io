---
title:  "Simple Rotation Matrices"
categories: Coding
---

Rotation matrices can be built by combining basic rotations in X, Y and Z ([see Wikipedia](http://en.wikipedia.org/wiki/Rotation_matrix#Basic_rotations)), but it's also possible to describe them by setting values in the matrix directly. I've recently found this useful as a quick way to create a matrix to convert from a space where the X and Y axes are flipped.

A rotation matrix can be built using three orthogonal vectors which define the original orientation of the X, Y and Z axes in the new coordinate space.

$$
R = \begin{bmatrix}
A_x & B_x & C_x & 0 \\
A_y & B_y & C_y & 0 \\
A_z & B_z & C_z & 0 \\
0 & 0 & 0 & 1
\end{bmatrix}
$$
where \\(A\\), \\(B\\) and \\(C\\) are unit vectors.

For the identity matrix (and hence no rotation), \\(A = \begin{pmatrix} 1 & 0 & 0 \end{pmatrix}\\), \\(B = \begin{pmatrix} 0 & 1 & 0 \end{pmatrix}\\) and \\(C = \begin{pmatrix} 0 & 0 & 1 \end{pmatrix}\\).

An Example
==========
This only made sense to me after trying a few examples.

Rotating 90 degrees around the X axis results in an orientation where:
* \\(X\_{orig}\\) is the original orientation of the X axis. \\(X\_{orig}\\) is equivalent to X because rotation was around the X axis. \\(X\_{orig} = \begin{pmatrix} 1 & 0 & 0 \end{pmatrix}\\)
* \\(Y\_{orig}\\) is the original orientation of the Y axis. It is now pointing along the new Z axis. \\(Y\_{orig} = \begin{pmatrix} 0 & 0 & 1 \end{pmatrix}\\)
* \\(Z\_{orig}\\) is the original orientation of the Z axis. It is now pointing along the negative Y axis. \\(Z\_{orig} = \begin{pmatrix} 0 & -1 & 0 \end{pmatrix}\\)

Putting these three vectors into the matrix above gives the following rotation matrix:
$$
R = \begin{bmatrix}
1 & 0 & 0 & 0 \\
0 & 0 & -1 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 0 & 1
\end{bmatrix}
$$

To verify this, here's the general matrix for rotation around X, where \\(\\theta\\) is the rotation angle:
$$
R_x(\theta) = \begin{bmatrix}
1 & 0 & 0 \\
0 & \cos \theta &  -\sin \theta \\
0 & \sin \theta  &  \cos \theta
\end{bmatrix}
$$

Setting \\(\\theta = 90° \\) gives:
$$
R = \begin{bmatrix}
1 & 0 & 0 & 0 \\
0 & 0 & -1 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 0 & 1
\end{bmatrix}
$$

Which is the same matrix that we originally created.