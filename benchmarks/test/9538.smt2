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

(declare-sort var3048 0)
(declare-sort var3538 0)
(declare-sort var924 0)
(declare-sort var1647 0)
(declare-sort var3830 0)
(declare-sort var3470 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getIdentifier/-338683473 (var1647) String)
(declare-fun cast-from-var3048-to-var1647 (var3048) var1647)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3830_info/484404803 (var3830 String) void)
(declare-fun cast-from-var924-to-var3830 (var924) var3830)
(declare-fun asyncReferringFutures/-1953096320 (var3048) var3470)
(declare-fun var3470_clear/2124191932 (var3470) void)
(declare-const null-var3048 var3048)
(declare-const null-var3538 var3538)
(declare-const var3048-logger var924)
(declare-const var3412 var3048) ; Statement: r2 := @this: org.apache.dubbo.config.deploy.DefaultModuleDeployer 
(assert (not (= var3412 null-var3048)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var504 var3538) ; Statement: $r20 := @caughtexception 
(assert (not (= var504 null-var3538)))
(define-const var1991 var924 var3048-logger) ; Statement: $r22 = <org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1373 String String-init) ; Statement: $r21 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1373)) ; Statement: specialinvoke $r21.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1373!1 String)
(assert (= var1373!1 ""))
(assert true)
(define-const var1382 String (getIdentifier/-338683473 (cast-from-var3048-to-var1647 var3412))) ; Statement: $r23 = virtualinvoke r2.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.lang.String getIdentifier()>() 
(assert true)
(define-const var1678 String (append/672562846 var1373!1 var1382)) ; Statement: $r24 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23) 
(declare-const var1373!2 String)
(assert (= var1373!2 (str.++ var1373!1 var1382)))
(assert true)
(define-const var1008 String (append/672562846 var1678 " refer services finished.")) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" refer services finished.") 
(declare-const var1678!1 String)
(assert (= var1678!1 (str.++ var1678 " refer services finished.")))
(assert true)
(define-const var275 String (toString/-2075883882 var1008)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3830_info/484404803 (cast-from-var924-to-var3830 var1991) var275)) ; Statement: interfaceinvoke $r22.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r26) 

(declare-const var1991!1 var924)
(declare-const var275!1 String)
(define-const var2226 var3470 (asyncReferringFutures/-1953096320 var3412)) ; Statement: $r27 = r2.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.util.List asyncReferringFutures> 
;(assert (var3470_clear/2124191932 var2226)) ; Statement: interfaceinvoke $r27.<java.util.List: void clear()>() 

(declare-const var2226!1 var3470)
 ; Statement: throw $r20 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getIdentifier/-338683473=([org.apache.dubbo.common.deploy.AbstractDeployer], java.lang.String), cast-from-var3048-to-var1647=([org.apache.dubbo.config.deploy.DefaultModuleDeployer], org.apache.dubbo.common.deploy.AbstractDeployer), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3830_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var924-to-var3830=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), asyncReferringFutures/-1953096320=([org.apache.dubbo.config.deploy.DefaultModuleDeployer], java.util.List), var3470_clear/2124191932=([java.util.List], void)}
; {var3048=org.apache.dubbo.config.deploy.DefaultModuleDeployer, var3412=r2, var3538=java.lang.Throwable, var504=$r20, var924=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1991=$r22, var1373=$r21, var1647=org.apache.dubbo.common.deploy.AbstractDeployer, var1382=$r23, var1678=$r24, var1008=$r25, var275=$r26, var3830=org.apache.dubbo.common.logger.Logger, var3470=java.util.List, var2226=$r27}
; {org.apache.dubbo.config.deploy.DefaultModuleDeployer=var3048, r2=var3412, java.lang.Throwable=var3538, $r20=var504, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var924, $r22=var1991, $r21=var1373, org.apache.dubbo.common.deploy.AbstractDeployer=var1647, $r23=var1382, $r24=var1678, $r25=var1008, $r26=var275, org.apache.dubbo.common.logger.Logger=var3830, java.util.List=var3470, $r27=var2226}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.config.deploy.DefaultModuleDeployer;	$r20 := @caughtexception;	$r22 = <org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r21 = new java.lang.StringBuilder;	specialinvoke $r21.<java.lang.StringBuilder: void <init>()>();	$r23 = virtualinvoke r2.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.lang.String getIdentifier()>();	$r24 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23);	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" refer services finished.");	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r22.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r26);	$r27 = r2.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.util.List asyncReferringFutures>;	interfaceinvoke $r27.<java.util.List: void clear()>();	throw $r20
;block_num 2