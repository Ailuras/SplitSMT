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

(declare-sort var841 0)
(declare-sort var2463 0)
(declare-sort var2952 0)
(declare-sort var1497 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameterAndDecoded/384969937 (var2463 String) String)
(declare-fun var2952_isEmpty/-813097145 (String) Bool)
(declare-fun var1497-init () var1497)
(declare-fun <init>/-1092629202 (var1497 String) void)
(declare-const null-var841 var841)
(declare-const null-var2463 var2463)
(declare-const var1387 var841) ; Statement: r3 := @this: org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter 
(assert (not (= var1387 null-var841)))
(declare-const var3796 var2463) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3796 null-var2463)))
(assert true)
(define-const var1045 String (getParameterAndDecoded/384969937 var3796 "rule")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameterAndDecoded(java.lang.String)>("rule") 
(define-const var2471 Bool (var2952_isEmpty/-813097145 var1045)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto return r1 
(assert (not (= (ite var2471 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1959 var1497 var1497-init) ; Statement: $r2 = new java.lang.IllegalStateException 
(assert true)
;(assert (<init>/-1092629202 var1959 "route rule can not be empty.")) ; Statement: specialinvoke $r2.<java.lang.IllegalStateException: void <init>(java.lang.String)>("route rule can not be empty.") 

(declare-const var1959!1 var1497)
(declare-const var2132 String)
 ; Statement: throw $r2 
(check-sat)
; {getParameterAndDecoded/384969937=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2952_isEmpty/-813097145=([java.lang.String], boolean), var1497-init=([], java.lang.IllegalStateException), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var841=org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter, var1387=r3, var2463=org.apache.dubbo.common.URL, var3796=r0, var1045=r1, var2952=org.apache.dubbo.common.utils.StringUtils, var2471=$z0, var1497=java.lang.IllegalStateException, var1959=$r2, var2132="route rule can not be empty."}
; {org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter=var841, r3=var1387, org.apache.dubbo.common.URL=var2463, r0=var3796, r1=var1045, org.apache.dubbo.common.utils.StringUtils=var2952, $z0=var2471, java.lang.IllegalStateException=var1497, $r2=var1959, "route rule can not be empty."=var2132}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter;	r0 := @parameter0: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameterAndDecoded(java.lang.String)>("rule");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto return r1;	$r2 = new java.lang.IllegalStateException;	specialinvoke $r2.<java.lang.IllegalStateException: void <init>(java.lang.String)>("route rule can not be empty.");	throw $r2
;block_num 2