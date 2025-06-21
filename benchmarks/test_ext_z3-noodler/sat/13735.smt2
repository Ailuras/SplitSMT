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

(declare-sort var1614 0)
(declare-sort var2581 0)
(declare-sort var2799 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceMethodParameter/-1810918120 (var1614 String String String) String)
(declare-fun var2799_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseByte/566405473 (String) Int)
(declare-const null-var1614 var1614)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var424 var1614) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var424 null-var1614)))
(declare-const var1697 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1697 null-String)))
(declare-const var3542 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3542 null-String)))
(declare-const var3807 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var3807 null-String)))
(declare-const var2366 Int) ; Statement: b1 := @parameter3: byte 
(assert (not (= var2366 null-Int)))
(assert true)
(define-const var3217 String (getServiceMethodParameter/-1810918120 var424 var1697 var3542 var3807)) ; Statement: r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3) 
(define-const var1967 Bool (var2799_isEmpty/-813097145 var3217)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r4) 
(assert (= (ite var1967 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3821 Int (Int_parseByte/566405473 var3217)) ; Statement: $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r4) 
 ; Statement: return $b0 
(check-sat)
; {getServiceMethodParameter/-1810918120=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, java.lang.String], java.lang.String), var2799_isEmpty/-813097145=([java.lang.String], boolean), Int_parseByte/566405473=([java.lang.String], byte)}
; {var1614=org.apache.dubbo.common.URL, var424=r0, var1697=r1, var2581=null_type, var3542=r2, var3807=r3, var2366=b1, var3217=r4, var2799=org.apache.dubbo.common.utils.StringUtils, var1967=$z0, var3821=$b0}
; {org.apache.dubbo.common.URL=var1614, r0=var424, r1=var1697, null_type=var2581, r2=var3542, r3=var3807, b1=var2366, r4=var3217, org.apache.dubbo.common.utils.StringUtils=var2799, $z0=var1967, $b0=var3821}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	b1 := @parameter3: byte;	r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r4);	$b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r4);	return $b0
;block_num 2