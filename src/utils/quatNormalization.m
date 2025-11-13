%small helper function to renormalize the quaternion after integration
function q = quatNormalization(q)
    q = q/norm(q);
end