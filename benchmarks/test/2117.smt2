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

(declare-sort var3012 0)
(declare-sort var316 0)
(declare-sort var3793 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2069355293 (var3012 String String) String)
(declare-fun var3793_isEmpty/-813097145 (String) Bool)
(declare-const null-var3012 var3012)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3851 var3012) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var3851 null-var3012)))
(declare-const var2543 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2543 null-String)))
(declare-const var1816 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1816 null-String)))
(declare-const var1519 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var1519 null-Int)))
(assert true)
(define-const var1223 String (getMethodParameter/2069355293 var3851 var2543 var1816)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var3701 Bool (var3793_isEmpty/-813097145 var1223)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r3) 
(assert (not (= (ite var3701 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return i1 
(check-sat)
; {getMethodParameter/2069355293=([org.apache.dubbo.common.Parameters, java.lang.String, java.lang.String], java.lang.String), var3793_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3012=org.apache.dubbo.common.Parameters, var3851=r0, var2543=r1, var316=null_type, var1816=r2, var1519=i1, var1223=r3, var3793=org.apache.dubbo.common.utils.StringUtils, var3701=$z0}
; {org.apache.dubbo.common.Parameters=var3012, r0=var3851, r1=var2543, null_type=var316, r2=var1816, i1=var1519, r3=var1223, org.apache.dubbo.common.utils.StringUtils=var3793, $z0=var3701}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	i1 := @parameter2: int;	r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r3);	return i1
;block_num 2