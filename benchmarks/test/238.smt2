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

(declare-sort var2933 0)
(declare-sort var1941 0)
(declare-sort var279 0)
(declare-sort var746 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var279-init () var279)
(declare-fun <init>/-201242697 (var279) void)
(declare-fun var746_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2933 var2933)
(declare-const null-String String)
(declare-const var1967 var2933) ; Statement: r60 := @this: org.apache.dubbo.rpc.cluster.router.condition.MultiDestConditionRouter 
(assert (not (= var1967 null-var2933)))
(declare-const var1108 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1108 null-String)))
(define-const var3920 var279 var279-init) ; Statement: $r0 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var3920)) ; Statement: specialinvoke $r0.<java.util.HashMap: void <init>()>() 

(declare-const var3920!1 var279)
(define-const var1806 Bool (var746_isBlank/-523695098 (cast-from-String-to-String var1108))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1) 
 ; Statement: if $z0 == 0 goto r61 = null 
(assert (not (= (ite var1806 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return $r0 
(check-sat)
; {var279-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), var746_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2933=org.apache.dubbo.rpc.cluster.router.condition.MultiDestConditionRouter, var1967=r60, var1108=r1, var1941=null_type, var279=java.util.HashMap, var3920=$r0, var746=org.apache.dubbo.common.utils.StringUtils, var1806=$z0}
; {org.apache.dubbo.rpc.cluster.router.condition.MultiDestConditionRouter=var2933, r60=var1967, r1=var1108, null_type=var1941, java.util.HashMap=var279, $r0=var3920, org.apache.dubbo.common.utils.StringUtils=var746, $z0=var1806}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r60 := @this: org.apache.dubbo.rpc.cluster.router.condition.MultiDestConditionRouter;	r1 := @parameter0: java.lang.String;	$r0 = new java.util.HashMap;	specialinvoke $r0.<java.util.HashMap: void <init>()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1);	if $z0 == 0 goto r61 = null;	return $r0
;block_num 2