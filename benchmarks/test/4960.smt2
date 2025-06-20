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

(declare-sort var1956 0)
(declare-sort var1212 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var1956 var1956)
(declare-const null-var1212 var1212)
(declare-const var3616 var1956) ; Statement: r6 := @this: org.apache.dubbo.config.ModuleConfig 
(assert (not (= var3616 null-var1956)))
(declare-const var301 var1212) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var301 null-var1212)))
(define-const var1262 Bool false) ; Statement: $z0 = r0 instanceof org.apache.dubbo.rpc.model.ModuleModel 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var1262 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {}
; {var1956=org.apache.dubbo.config.ModuleConfig, var3616=r6, var1212=org.apache.dubbo.rpc.model.ScopeModel, var301=r0, var1262=$z0}
; {org.apache.dubbo.config.ModuleConfig=var1956, r6=var3616, org.apache.dubbo.rpc.model.ScopeModel=var1212, r0=var301, $z0=var1262}
;seq 
;cnt {}
;stmts r6 := @this: org.apache.dubbo.config.ModuleConfig;	r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel;	$z0 = r0 instanceof org.apache.dubbo.rpc.model.ModuleModel;	if $z0 != 0 goto return;	return
;block_num 2