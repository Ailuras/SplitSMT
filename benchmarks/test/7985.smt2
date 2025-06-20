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

(declare-sort var2207 0)
(declare-sort var400 0)
(declare-sort var3051 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getModelName/-2051809897 (var400) String)
(declare-fun cast-from-var2207-to-var400 (var2207) var400)
(declare-fun var3051_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2207 var2207)
(declare-const var3196 var2207) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ApplicationModel 
(assert (not (= var3196 null-var2207)))
(assert true)
(define-const var3172 String (getModelName/-2051809897 (cast-from-var2207-to-var400 var3196))) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getModelName()>() 
(define-const var745 Bool (var3051_isBlank/-523695098 (cast-from-String-to-String var3172))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1) 
 ; Statement: if $z0 == 0 goto return r1 
(assert (= (ite var745 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r1 
(check-sat)
; {getModelName/-2051809897=([org.apache.dubbo.rpc.model.ScopeModel], java.lang.String), cast-from-var2207-to-var400=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), var3051_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2207=org.apache.dubbo.rpc.model.ApplicationModel, var3196=r0, var400=org.apache.dubbo.rpc.model.ScopeModel, var3172=r1, var3051=org.apache.dubbo.common.utils.StringUtils, var745=$z0}
; {org.apache.dubbo.rpc.model.ApplicationModel=var2207, r0=var3196, org.apache.dubbo.rpc.model.ScopeModel=var400, r1=var3172, org.apache.dubbo.common.utils.StringUtils=var3051, $z0=var745}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.model.ApplicationModel;	r1 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getModelName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1);	if $z0 == 0 goto return r1;	return r1
;block_num 2