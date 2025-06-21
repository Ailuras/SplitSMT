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

(declare-sort var2831 0)
(declare-sort var3330 0)
(declare-sort var596 0)
(declare-sort var812 0)
(declare-sort var3394 0)
(declare-sort var3157 0)
(declare-sort var2227 0)
(declare-sort var2325 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var812_isDebugEnabled/-823448366 (var812) Bool)
(declare-fun cast-from-var596-to-var812 (var596) var812)
(declare-fun var3394-init () var3394)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var596_error/377575788 (var596 String String String String var2227) void)
(declare-fun cast-from-var3157-to-var2227 (var3157) var2227)
(declare-fun ruleMapHolder/253099168 (var2831) var2325)
(declare-const null-var2831 var2831)
(declare-const null-String String)
(declare-const var2831-logger var596)
(declare-const null-var3157 var3157)
(declare-const null-var2325 var2325)
(declare-const var2513 var2831) ; Statement: r9 := @this: org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener 
(assert (not (= var2513 null-var2831)))
(declare-const var847 String) ; Statement: r8 := @parameter0: java.lang.String 
(assert (not (= var847 null-String)))
(define-const var1978 var596 var2831-logger) ; Statement: $r0 = <org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1780 Bool (var812_isDebugEnabled/-823448366 (cast-from-var596-to-var812 var1978))) ; Statement: $z0 = interfaceinvoke $r0.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z0 == 0 goto $r47 = new java.util.HashMap 
(assert (= (ite var1780 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1419 var3394 var3394-init) ; Statement: $r47 = new java.util.HashMap 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3673 var3157) ; Statement: $r41 := @caughtexception 
(assert (not (= var3673 null-var3157)))
(define-const var608 var596 var2831-logger) ; Statement: $r43 = <org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3787 String String-init) ; Statement: $r55 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3787)) ; Statement: specialinvoke $r55.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3787!1 String)
(assert (= var3787!1 ""))
(assert true)
(define-const var3726 String (append/672562846 var3787!1 "[MeshAppRule] parse failed: ")) ; Statement: $r44 = virtualinvoke $r55.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[MeshAppRule] parse failed: ") 
(declare-const var3787!2 String)
(assert (= var3787!2 (str.++ var3787!1 "[MeshAppRule] parse failed: ")))
(assert true)
(define-const var3908 String (append/672562846 var3726 var847)) ; Statement: $r45 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var3726!1 String)
(assert (= var3726!1 (str.++ var3726 var847)))
(assert true)
(define-const var3536 String (toString/-2075883882 var3908)) ; Statement: $r46 = virtualinvoke $r45.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var596_error/377575788 var608 "2-13" "failed to receive mesh app route rule" "" var3536 (cast-from-var3157-to-var2227 var3673))) ; Statement: interfaceinvoke $r43.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-13", "failed to receive mesh app route rule", "", $r46, $r41) 

(declare-const var608!1 var596)
(declare-const var265 String)
(declare-const var2877 String)
(declare-const var1053 String)
(declare-const var3536!1 String)
(declare-const var3673!1 var3157)
(assert true) ; Non Conditional
(define-const var3501 var2325 (ruleMapHolder/253099168 var2513)) ; Statement: $r10 = r9.<org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener: java.util.Map ruleMapHolder> 
 ; Statement: if $r10 == null goto return 
(assert (= var3501 null-var2325)) ; Cond: $r10 == null 
 ; Statement: return 
(check-sat)
; {var812_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var596-to-var812=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), var3394-init=([], java.util.HashMap), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var596_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var3157-to-var2227=([java.lang.Exception], java.lang.Throwable), ruleMapHolder/253099168=([org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener], java.util.Map)}
; {var2831=org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener, var2513=r9, var847=r8, var3330=null_type, var596=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1978=$r0, var812=org.apache.dubbo.common.logger.Logger, var1780=$z0, var3394=java.util.HashMap, var1419=$r47, var3157=java.lang.Exception, var3673=$r41, var608=$r43, var3787=$r55, var3726=$r44, var3908=$r45, var3536=$r46, var2227=java.lang.Throwable, var265="2-13", var2877="failed to receive mesh app route rule", var1053="", var2325=java.util.Map, var3501=$r10}
; {org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener=var2831, r9=var2513, r8=var847, null_type=var3330, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var596, $r0=var1978, org.apache.dubbo.common.logger.Logger=var812, $z0=var1780, java.util.HashMap=var3394, $r47=var1419, java.lang.Exception=var3157, $r41=var3673, $r43=var608, $r55=var3787, $r44=var3726, $r45=var3908, $r46=var3536, java.lang.Throwable=var2227, "2-13"=var265, "failed to receive mesh app route rule"=var2877, ""=var1053, java.util.Map=var2325, $r10=var3501}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @this: org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener;	r8 := @parameter0: java.lang.String;	$r0 = <org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z0 = interfaceinvoke $r0.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z0 == 0 goto $r47 = new java.util.HashMap;	$r47 = new java.util.HashMap;	$r41 := @caughtexception;	$r43 = <org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r55 = new java.lang.StringBuilder;	specialinvoke $r55.<java.lang.StringBuilder: void <init>()>();	$r44 = virtualinvoke $r55.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[MeshAppRule] parse failed: ");	$r45 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r46 = virtualinvoke $r45.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r43.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-13", "failed to receive mesh app route rule", "", $r46, $r41);	$r10 = r9.<org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener: java.util.Map ruleMapHolder>;	if $r10 == null goto return;	return
;block_num 5