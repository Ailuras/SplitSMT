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

(declare-sort var773 0)
(declare-sort var2371 0)
(declare-sort var585 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceMethodParameter/-1810918120 (var773 String String String) String)
(declare-fun var585_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-const null-var773 var773)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2431 var773) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2431 null-var773)))
(declare-const var720 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var720 null-String)))
(declare-const var861 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var861 null-String)))
(declare-const var3004 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var3004 null-String)))
(declare-const var1042 Int) ; Statement: i1 := @parameter3: int 
(assert (not (= var1042 null-Int)))
(assert true)
(define-const var1544 String (getServiceMethodParameter/-1810918120 var2431 var720 var861 var3004)) ; Statement: r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3) 
(define-const var2118 Bool (var585_isEmpty/-813097145 var1544)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r4) 
(assert (= (ite var2118 1 0) 0)) ; Cond: $z0 == 0 
(define-const var734 Int (Int_parseInt/1370970945 var1544)) ; Statement: $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r4) 
 ; Statement: return $i0 
(check-sat)
; {getServiceMethodParameter/-1810918120=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, java.lang.String], java.lang.String), var585_isEmpty/-813097145=([java.lang.String], boolean), Int_parseInt/1370970945=([java.lang.String], int)}
; {var773=org.apache.dubbo.common.URL, var2431=r0, var720=r1, var2371=null_type, var861=r2, var3004=r3, var1042=i1, var1544=r4, var585=org.apache.dubbo.common.utils.StringUtils, var2118=$z0, var734=$i0}
; {org.apache.dubbo.common.URL=var773, r0=var2431, r1=var720, null_type=var2371, r2=var861, r3=var3004, i1=var1042, r4=var1544, org.apache.dubbo.common.utils.StringUtils=var585, $z0=var2118, $i0=var734}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	i1 := @parameter3: int;	r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r4);	$i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r4);	return $i0
;block_num 2