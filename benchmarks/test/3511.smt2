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

(declare-sort var1058 0)
(declare-sort var2596 0)
(declare-sort var3935 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2596_getKeyIndex/82410026 (Bool String) Int)
(declare-fun var3935_getIndex/-716073727 (var3935 String) Int)
(declare-const null-String String)
(declare-const var2596-VALUES (Array Int var3935))
(declare-const var2716 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2716 null-String)))
(declare-const var828 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var828 null-String)))
(define-const var2253 Int (var2596_getKeyIndex/82410026 (ite (= 1 1) true false) var2716)) ; Statement: i0 = staticinvoke <org.apache.dubbo.common.url.component.param.DynamicParamTable: int getKeyIndex(boolean,java.lang.String)>(1, r0) 
 ; Statement: if i0 >= 0 goto $r1 = <org.apache.dubbo.common.url.component.param.DynamicParamTable: org.apache.dubbo.common.url.component.param.ParamValue[] VALUES> 
(assert (>= var2253 0)) ; Cond: i0 >= 0 
(define-const var0 (Array Int var3935) var2596-VALUES) ; Statement: $r1 = <org.apache.dubbo.common.url.component.param.DynamicParamTable: org.apache.dubbo.common.url.component.param.ParamValue[] VALUES> 
(define-const var2228 var3935 (select var0 var2253)) ; Statement: r2 = $r1[i0] 
(define-const var1068 Int (var3935_getIndex/-716073727 var2228 var828)) ; Statement: $i1 = interfaceinvoke r2.<org.apache.dubbo.common.url.component.param.ParamValue: int getIndex(java.lang.String)>(r3) 
 ; Statement: return $i1 
(check-sat)
; {var2596_getKeyIndex/82410026=([boolean, java.lang.String], int), var3935_getIndex/-716073727=([org.apache.dubbo.common.url.component.param.ParamValue, java.lang.String], int)}
; {var2716=r0, var1058=null_type, var828=r3, var2596=org.apache.dubbo.common.url.component.param.DynamicParamTable, var2253=i0, var3935=org.apache.dubbo.common.url.component.param.ParamValue, var0=$r1, var2228=r2, var1068=$i1}
; {r0=var2716, null_type=var1058, r3=var828, org.apache.dubbo.common.url.component.param.DynamicParamTable=var2596, i0=var2253, org.apache.dubbo.common.url.component.param.ParamValue=var3935, $r1=var0, r2=var2228, $i1=var1068}
;seq 
;cnt {}
;stmts r0 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	i0 = staticinvoke <org.apache.dubbo.common.url.component.param.DynamicParamTable: int getKeyIndex(boolean,java.lang.String)>(1, r0);	if i0 >= 0 goto $r1 = <org.apache.dubbo.common.url.component.param.DynamicParamTable: org.apache.dubbo.common.url.component.param.ParamValue[] VALUES>;	$r1 = <org.apache.dubbo.common.url.component.param.DynamicParamTable: org.apache.dubbo.common.url.component.param.ParamValue[] VALUES>;	r2 = $r1[i0];	$i1 = interfaceinvoke r2.<org.apache.dubbo.common.url.component.param.ParamValue: int getIndex(java.lang.String)>(r3);	return $i1
;block_num 2