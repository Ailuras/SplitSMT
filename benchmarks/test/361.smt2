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

(declare-sort var2584 0)
(declare-sort var1896 0)
(declare-sort var2509 0)
(declare-sort var3889 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2509-init () var2509)
(declare-fun <init>/-201242697 (var2509) void)
(declare-fun var3889_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2584 var2584)
(declare-const null-String String)
(declare-const var3548 var2584) ; Statement: r60 := @this: org.apache.dubbo.rpc.cluster.router.condition.ConditionStateRouter 
(assert (not (= var3548 null-var2584)))
(declare-const var2248 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2248 null-String)))
(define-const var2175 var2509 var2509-init) ; Statement: $r0 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var2175)) ; Statement: specialinvoke $r0.<java.util.HashMap: void <init>()>() 

(declare-const var2175!1 var2509)
(define-const var1483 Bool (var3889_isBlank/-523695098 (cast-from-String-to-String var2248))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1) 
 ; Statement: if $z0 == 0 goto r61 = null 
(assert (not (= (ite var1483 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return $r0 
(check-sat)
; {var2509-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), var3889_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2584=org.apache.dubbo.rpc.cluster.router.condition.ConditionStateRouter, var3548=r60, var2248=r1, var1896=null_type, var2509=java.util.HashMap, var2175=$r0, var3889=org.apache.dubbo.common.utils.StringUtils, var1483=$z0}
; {org.apache.dubbo.rpc.cluster.router.condition.ConditionStateRouter=var2584, r60=var3548, r1=var2248, null_type=var1896, java.util.HashMap=var2509, $r0=var2175, org.apache.dubbo.common.utils.StringUtils=var3889, $z0=var1483}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r60 := @this: org.apache.dubbo.rpc.cluster.router.condition.ConditionStateRouter;	r1 := @parameter0: java.lang.String;	$r0 = new java.util.HashMap;	specialinvoke $r0.<java.util.HashMap: void <init>()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1);	if $z0 == 0 goto r61 = null;	return $r0
;block_num 2