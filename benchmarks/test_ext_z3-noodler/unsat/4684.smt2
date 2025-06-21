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

(declare-sort var2995 0)
(declare-sort var1011 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var2995 var2995)
(declare-const null-var1011 var1011)
(declare-const var2269 var2995) ; Statement: r6 := @this: org.apache.dubbo.config.AbstractMethodConfig 
(assert (not (= var2269 null-var2995)))
(declare-const var3022 var1011) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var3022 null-var1011)))
(define-const var2974 Bool false) ; Statement: $z0 = r0 instanceof org.apache.dubbo.rpc.model.ModuleModel 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var2974 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {}
; {var2995=org.apache.dubbo.config.AbstractMethodConfig, var2269=r6, var1011=org.apache.dubbo.rpc.model.ScopeModel, var3022=r0, var2974=$z0}
; {org.apache.dubbo.config.AbstractMethodConfig=var2995, r6=var2269, org.apache.dubbo.rpc.model.ScopeModel=var1011, r0=var3022, $z0=var2974}
;seq 
;cnt {}
;stmts r6 := @this: org.apache.dubbo.config.AbstractMethodConfig;	r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel;	$z0 = r0 instanceof org.apache.dubbo.rpc.model.ModuleModel;	if $z0 != 0 goto return;	return
;block_num 2