(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3810 0)
(declare-sort var3043 0)
(declare-sort var3082 0)
(declare-sort var1448 0)
(declare-sort var3482 0)
(declare-sort var2455 0)
(declare-sort var3407 0)
(declare-sort var1936 0)
(declare-sort var2284 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3082-init () var3082)
(declare-fun defaultSerializeClassChecker/1153080070 (var3810) var1448)
(declare-fun <init>/-44530463 (var3082 var3043 var1448) void)
(declare-fun var3482_getSystemProperty/1393069448 (String) String)
(declare-fun getClassFactory/160840225 (var3407) var2455)
(declare-fun cast-from-var3082-to-var3407 (var3082) var3407)
(declare-fun setWhitelist/-1843054418 (var2455 Bool) void)
(declare-fun var1936_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var3482_getSystemProperty/590859155 (String String) String)
(declare-fun var2284_parseBoolean/746105335 (String) Bool)
(declare-fun setAllowNonSerializable/-611198900 (var3407 Bool) void)
(declare-fun allow/2012140109 (var2455 String) void)
(declare-const null-var3810 var3810)
(declare-const null-var3043 var3043)
(declare-const var1845 var3810) ; Statement: r2 := @this: org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager 
(assert (not (= var1845 null-var3810)))
(declare-const var518 var3043) ; Statement: r1 := @parameter0: java.lang.ClassLoader 
(assert (not (= var518 null-var3043)))
(define-const var3866 var3082 var3082-init) ; Statement: $r0 = new org.apache.dubbo.common.serialize.hessian2.Hessian2SerializerFactory 
(define-const var3948 var1448 (defaultSerializeClassChecker/1153080070 var1845)) ; Statement: $r3 = r2.<org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager: org.apache.dubbo.common.utils.DefaultSerializeClassChecker defaultSerializeClassChecker> 
(assert true)
;(assert (<init>/-44530463 var3866 var518 var3948)) ; Statement: specialinvoke $r0.<org.apache.dubbo.common.serialize.hessian2.Hessian2SerializerFactory: void <init>(java.lang.ClassLoader,org.apache.dubbo.common.utils.DefaultSerializeClassChecker)>(r1, $r3) 

(declare-const var3866!1 var3082)
(declare-const var518!1 var3043)
(declare-const var3948!1 var1448)
(define-const var2367 String (var3482_getSystemProperty/1393069448 "dubbo.application.hessian2.whitelist")) ; Statement: r4 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.application.hessian2.whitelist") 
(define-const var3429 String "true") ; Statement: $r5 = "true" 
(assert true)
(define-const var741 Bool (= var3429 var2367)) ; Statement: $z0 = virtualinvoke $r5.<java.lang.String: boolean equals(java.lang.Object)>(r4) 
 ; Statement: if $z0 == 0 goto $r6 = virtualinvoke $r0.<com.alibaba.com.caucho.hessian.io.SerializerFactory: com.alibaba.com.caucho.hessian.io.ClassFactory getClassFactory()>() 
(assert (= (ite var741 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1301 var2455 (getClassFactory/160840225 (cast-from-var3082-to-var3407 var3866!1))) ; Statement: $r6 = virtualinvoke $r0.<com.alibaba.com.caucho.hessian.io.SerializerFactory: com.alibaba.com.caucho.hessian.io.ClassFactory getClassFactory()>() 
(assert true)
;(assert (setWhitelist/-1843054418 var1301 (ite (= 1 0) true false))) ; Statement: virtualinvoke $r6.<com.alibaba.com.caucho.hessian.io.ClassFactory: void setWhitelist(boolean)>(0) 

(declare-const var1301!1 var2455)
(declare-const var1771 Int)
(define-const var2273 String (var3482_getSystemProperty/1393069448 "dubbo.application.hessian2.deny")) ; Statement: r17 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.application.hessian2.deny") 
(define-const var369 Bool (var1936_isNotEmpty/-1251449450 var2273)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r17) 
 ; Statement: if $z1 == 0 goto $r20 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.hessian.allowNonSerializable", "false") 
(assert (= (ite var369 1 0) 0)) ; Cond: $z1 == 0 
(define-const var2066 String (var3482_getSystemProperty/590859155 "dubbo.hessian.allowNonSerializable" "false")) ; Statement: $r20 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.hessian.allowNonSerializable", "false") 
(define-const var1324 Bool (var2284_parseBoolean/746105335 var2066)) ; Statement: $z3 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>($r20) 
(assert true)
;(assert (setAllowNonSerializable/-611198900 (cast-from-var3082-to-var3407 var3866!1) var1324)) ; Statement: virtualinvoke $r0.<com.alibaba.com.caucho.hessian.io.SerializerFactory: void setAllowNonSerializable(boolean)>($z3) 

(declare-const var3866!2 var3082)
(declare-const var1324!1 Bool)
(assert true)
(define-const var984 var2455 (getClassFactory/160840225 (cast-from-var3082-to-var3407 var3866!2))) ; Statement: $r21 = virtualinvoke $r0.<com.alibaba.com.caucho.hessian.io.SerializerFactory: com.alibaba.com.caucho.hessian.io.ClassFactory getClassFactory()>() 
(assert true)
;(assert (allow/2012140109 var984 "org.apache.dubbo.*")) ; Statement: virtualinvoke $r21.<com.alibaba.com.caucho.hessian.io.ClassFactory: void allow(java.lang.String)>("org.apache.dubbo.*") 

(declare-const var984!1 var2455)
(declare-const var2457 String)
 ; Statement: return $r0 
(check-sat)
; {var3082-init=([], org.apache.dubbo.common.serialize.hessian2.Hessian2SerializerFactory), defaultSerializeClassChecker/1153080070=([org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager], org.apache.dubbo.common.utils.DefaultSerializeClassChecker), <init>/-44530463=([org.apache.dubbo.common.serialize.hessian2.Hessian2SerializerFactory, java.lang.ClassLoader, org.apache.dubbo.common.utils.DefaultSerializeClassChecker], void), var3482_getSystemProperty/1393069448=([java.lang.String], java.lang.String), getClassFactory/160840225=([com.alibaba.com.caucho.hessian.io.SerializerFactory], com.alibaba.com.caucho.hessian.io.ClassFactory), cast-from-var3082-to-var3407=([org.apache.dubbo.common.serialize.hessian2.Hessian2SerializerFactory], com.alibaba.com.caucho.hessian.io.SerializerFactory), setWhitelist/-1843054418=([com.alibaba.com.caucho.hessian.io.ClassFactory, boolean], void), var1936_isNotEmpty/-1251449450=([java.lang.String], boolean), var3482_getSystemProperty/590859155=([java.lang.String, java.lang.String], java.lang.String), var2284_parseBoolean/746105335=([java.lang.String], boolean), setAllowNonSerializable/-611198900=([com.alibaba.com.caucho.hessian.io.SerializerFactory, boolean], void), allow/2012140109=([com.alibaba.com.caucho.hessian.io.ClassFactory, java.lang.String], void)}
; {var3810=org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager, var1845=r2, var3043=java.lang.ClassLoader, var518=r1, var3082=org.apache.dubbo.common.serialize.hessian2.Hessian2SerializerFactory, var3866=$r0, var1448=org.apache.dubbo.common.utils.DefaultSerializeClassChecker, var3948=$r3, var3482=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var2367=r4, var3429=$r5, var741=$z0, var2455=com.alibaba.com.caucho.hessian.io.ClassFactory, var3407=com.alibaba.com.caucho.hessian.io.SerializerFactory, var1301=$r6, var1771=0, var2273=r17, var1936=org.apache.dubbo.common.utils.StringUtils, var369=$z1, var2066=$r20, var2284=java.lang.Boolean, var1324=$z3, var984=$r21, var2457="org.apache.dubbo.*"}
; {org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager=var3810, r2=var1845, java.lang.ClassLoader=var3043, r1=var518, org.apache.dubbo.common.serialize.hessian2.Hessian2SerializerFactory=var3082, $r0=var3866, org.apache.dubbo.common.utils.DefaultSerializeClassChecker=var1448, $r3=var3948, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var3482, r4=var2367, $r5=var3429, $z0=var741, com.alibaba.com.caucho.hessian.io.ClassFactory=var2455, com.alibaba.com.caucho.hessian.io.SerializerFactory=var3407, $r6=var1301, 0=var1771, r17=var2273, org.apache.dubbo.common.utils.StringUtils=var1936, $z1=var369, $r20=var2066, java.lang.Boolean=var2284, $z3=var1324, $r21=var984, "org.apache.dubbo.*"=var2457}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager;	r1 := @parameter0: java.lang.ClassLoader;	$r0 = new org.apache.dubbo.common.serialize.hessian2.Hessian2SerializerFactory;	$r3 = r2.<org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager: org.apache.dubbo.common.utils.DefaultSerializeClassChecker defaultSerializeClassChecker>;	specialinvoke $r0.<org.apache.dubbo.common.serialize.hessian2.Hessian2SerializerFactory: void <init>(java.lang.ClassLoader,org.apache.dubbo.common.utils.DefaultSerializeClassChecker)>(r1, $r3);	r4 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.application.hessian2.whitelist");	$r5 = "true";	$z0 = virtualinvoke $r5.<java.lang.String: boolean equals(java.lang.Object)>(r4);	if $z0 == 0 goto $r6 = virtualinvoke $r0.<com.alibaba.com.caucho.hessian.io.SerializerFactory: com.alibaba.com.caucho.hessian.io.ClassFactory getClassFactory()>();	$r6 = virtualinvoke $r0.<com.alibaba.com.caucho.hessian.io.SerializerFactory: com.alibaba.com.caucho.hessian.io.ClassFactory getClassFactory()>();	virtualinvoke $r6.<com.alibaba.com.caucho.hessian.io.ClassFactory: void setWhitelist(boolean)>(0);	r17 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.application.hessian2.deny");	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r17);	if $z1 == 0 goto $r20 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.hessian.allowNonSerializable", "false");	$r20 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.hessian.allowNonSerializable", "false");	$z3 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>($r20);	virtualinvoke $r0.<com.alibaba.com.caucho.hessian.io.SerializerFactory: void setAllowNonSerializable(boolean)>($z3);	$r21 = virtualinvoke $r0.<com.alibaba.com.caucho.hessian.io.SerializerFactory: com.alibaba.com.caucho.hessian.io.ClassFactory getClassFactory()>();	virtualinvoke $r21.<com.alibaba.com.caucho.hessian.io.ClassFactory: void allow(java.lang.String)>("org.apache.dubbo.*");	return $r0
;block_num 3