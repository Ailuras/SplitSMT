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

(declare-sort var2345 0)
(declare-sort var3963 0)
(declare-sort var2415 0)
(declare-sort var3147 0)
(declare-sort var1213 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2415-init () var2415)
(declare-fun var3147_toString/2086998539 (String var1213) String)
(declare-fun cast-from-var3963-to-var1213 (var3963) var1213)
(declare-fun <init>/-1557872005 (var2415 String) void)
(declare-const null-var2345 var2345)
(declare-const null-var3963 var3963)
(declare-const var1556 var2345) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult 
(assert (not (= var1556 null-var2345)))
(declare-const var2272 var3963) ; Statement: r1 := @parameter0: java.lang.Exception 
(assert (not (= var2272 null-var3963)))
(define-const var2293 var2415 var2415-init) ; Statement: $r0 = new java.io.IOException 
(define-const var3261 String (var3147_toString/2086998539 "Read response data failed." (cast-from-var3963-to-var1213 var2272))) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.String,java.lang.Throwable)>("Read response data failed.", r1) 
(assert true)
;(assert (<init>/-1557872005 var2293 var3261)) ; Statement: specialinvoke $r0.<java.io.IOException: void <init>(java.lang.String)>($r2) 

(declare-const var2293!1 var2415)
(declare-const var3261!1 String)
 ; Statement: throw $r0 
(check-sat)
; {var2415-init=([], java.io.IOException), var3147_toString/2086998539=([java.lang.String, java.lang.Throwable], java.lang.String), cast-from-var3963-to-var1213=([java.lang.Exception], java.lang.Throwable), <init>/-1557872005=([java.io.IOException, java.lang.String], void)}
; {var2345=org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult, var1556=r3, var3963=java.lang.Exception, var2272=r1, var2415=java.io.IOException, var2293=$r0, var3147=org.apache.dubbo.common.utils.StringUtils, var1213=java.lang.Throwable, var3261=$r2}
; {org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult=var2345, r3=var1556, java.lang.Exception=var3963, r1=var2272, java.io.IOException=var2415, $r0=var2293, org.apache.dubbo.common.utils.StringUtils=var3147, java.lang.Throwable=var1213, $r2=var3261}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.String,java.lang.Throwable)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.String,java.lang.Throwable)>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult;	r1 := @parameter0: java.lang.Exception;	$r0 = new java.io.IOException;	$r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.String,java.lang.Throwable)>("Read response data failed.", r1);	specialinvoke $r0.<java.io.IOException: void <init>(java.lang.String)>($r2);	throw $r0
;block_num 1