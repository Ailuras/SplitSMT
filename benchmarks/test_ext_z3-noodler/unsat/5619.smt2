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

(declare-sort var2964 0)
(declare-sort var2756 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var2964 var2964)
(declare-const null-var2756 var2756)
(declare-const var2923 var2964) ; Statement: r6 := @this: org.apache.dubbo.config.AbstractConfig 
(assert (not (= var2923 null-var2964)))
(declare-const var1865 var2756) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var1865 null-var2756)))
(define-const var2238 Bool false) ; Statement: $z0 = r0 instanceof org.apache.dubbo.rpc.model.ApplicationModel 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var2238 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {}
; {var2964=org.apache.dubbo.config.AbstractConfig, var2923=r6, var2756=org.apache.dubbo.rpc.model.ScopeModel, var1865=r0, var2238=$z0}
; {org.apache.dubbo.config.AbstractConfig=var2964, r6=var2923, org.apache.dubbo.rpc.model.ScopeModel=var2756, r0=var1865, $z0=var2238}
;seq 
;cnt {}
;stmts r6 := @this: org.apache.dubbo.config.AbstractConfig;	r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel;	$z0 = r0 instanceof org.apache.dubbo.rpc.model.ApplicationModel;	if $z0 != 0 goto return;	return
;block_num 2