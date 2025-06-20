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

(declare-sort var2671 0)
(declare-sort var1555 0)
(declare-sort var145 0)
(declare-sort var61 0)
(declare-sort var590 0)
(declare-sort var2471 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var590) String)
(declare-fun cast-from-var2671-to-var590 (var2671) var590)
(declare-fun var145_error/377575788 (var145 String String String String var2471) void)
(declare-fun cast-from-var1555-to-var2471 (var1555) var2471)
(declare-const null-var2671 var2671)
(declare-const null-var1555 var1555)
(declare-const var61-logger var145)
(declare-const var3720 var2671) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var3720 null-var2671)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3131 var1555) ; Statement: $r3 := @caughtexception 
(assert (not (= var3131 null-var1555)))
(define-const var2304 var145 var61-logger) ; Statement: $r4 = <org.apache.dubbo.rpc.cluster.router.tag.model.Tag: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1451 String (String_valueOf/-333372740 (cast-from-var2671-to-var590 var3720))) ; Statement: $r5 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
;(assert (var145_error/377575788 var2304 "2-15" " Failed to parse tag rule " var1451 "Error occurred when parsing rule component." (cast-from-var1555-to-var2471 var3131))) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-15", " Failed to parse tag rule ", $r5, "Error occurred when parsing rule component.", $r3) 

(declare-const var2304!1 var145)
(declare-const var1378 String)
(declare-const var204 String)
(declare-const var1451!1 String)
(declare-const var3113 String)
(declare-const var3131!1 var1555)
 ; Statement: return null 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-var2671-to-var590=([java.util.Map], java.lang.Object), var145_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var1555-to-var2471=([java.lang.ReflectiveOperationException], java.lang.Throwable)}
; {var2671=java.util.Map, var3720=r0, var1555=java.lang.ReflectiveOperationException, var3131=$r3, var145=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var61=org.apache.dubbo.rpc.cluster.router.tag.model.Tag, var2304=$r4, var590=java.lang.Object, var1451=$r5, var2471=java.lang.Throwable, var1378="2-15", var204=" Failed to parse tag rule ", var3113="Error occurred when parsing rule component."}
; {java.util.Map=var2671, r0=var3720, java.lang.ReflectiveOperationException=var1555, $r3=var3131, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var145, org.apache.dubbo.rpc.cluster.router.tag.model.Tag=var61, $r4=var2304, java.lang.Object=var590, $r5=var1451, java.lang.Throwable=var2471, "2-15"=var1378, " Failed to parse tag rule "=var204, "Error occurred when parsing rule component."=var3113}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.util.Map;	$r3 := @caughtexception;	$r4 = <org.apache.dubbo.rpc.cluster.router.tag.model.Tag: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r5 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-15", " Failed to parse tag rule ", $r5, "Error occurred when parsing rule component.", $r3);	return null
;block_num 2