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

(declare-sort var162 0)
(declare-sort var332 0)
(declare-sort var1595 0)
(declare-sort var471 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1595_getProperty/-78901247 (var162 String) String)
(declare-fun var471_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var162 var162)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var529 var162) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var529 null-var162)))
(declare-const var335 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var335 null-String)))
(declare-const var2548 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var2548 null-Int)))
(define-const var844 String (var1595_getProperty/-78901247 var529 var335)) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: java.lang.String getProperty(org.apache.dubbo.rpc.model.ScopeModel,java.lang.String)>(r0, r1) 
(define-const var995 Int var2548) ; Statement: i1 = i0 
(define-const var2229 Bool (var471_isNotEmpty/-1251449450 var844)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto return i1 
(assert (= (ite var2229 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return i1 
(check-sat)
; {var1595_getProperty/-78901247=([org.apache.dubbo.rpc.model.ScopeModel, java.lang.String], java.lang.String), var471_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var162=org.apache.dubbo.rpc.model.ScopeModel, var529=r0, var335=r1, var332=null_type, var2548=i0, var1595=org.apache.dubbo.common.config.ConfigurationUtils, var844=r2, var995=i1, var471=org.apache.dubbo.common.utils.StringUtils, var2229=$z0}
; {org.apache.dubbo.rpc.model.ScopeModel=var162, r0=var529, r1=var335, null_type=var332, i0=var2548, org.apache.dubbo.common.config.ConfigurationUtils=var1595, r2=var844, i1=var995, org.apache.dubbo.common.utils.StringUtils=var471, $z0=var2229}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel;	r1 := @parameter1: java.lang.String;	i0 := @parameter2: int;	r2 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: java.lang.String getProperty(org.apache.dubbo.rpc.model.ScopeModel,java.lang.String)>(r0, r1);	i1 = i0;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto return i1;	return i1
;block_num 2