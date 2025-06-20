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

(declare-sort var3112 0)
(declare-sort var1105 0)
(declare-sort var1698 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceMethodParameter/-1810918120 (var3112 String String String) String)
(declare-fun var1698_isEmpty/-813097145 (String) Bool)
(declare-const null-var3112 var3112)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1867 var3112) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1867 null-var3112)))
(declare-const var679 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var679 null-String)))
(declare-const var46 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var46 null-String)))
(declare-const var3351 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var3351 null-String)))
(declare-const var668 Int) ; Statement: b1 := @parameter3: byte 
(assert (not (= var668 null-Int)))
(assert true)
(define-const var3504 String (getServiceMethodParameter/-1810918120 var1867 var679 var46 var3351)) ; Statement: r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3) 
(define-const var3374 Bool (var1698_isEmpty/-813097145 var3504)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r4) 
(assert (not (= (ite var3374 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return b1 
(check-sat)
; {getServiceMethodParameter/-1810918120=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, java.lang.String], java.lang.String), var1698_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3112=org.apache.dubbo.common.URL, var1867=r0, var679=r1, var1105=null_type, var46=r2, var3351=r3, var668=b1, var3504=r4, var1698=org.apache.dubbo.common.utils.StringUtils, var3374=$z0}
; {org.apache.dubbo.common.URL=var3112, r0=var1867, r1=var679, null_type=var1105, r2=var46, r3=var3351, b1=var668, r4=var3504, org.apache.dubbo.common.utils.StringUtils=var1698, $z0=var3374}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	b1 := @parameter3: byte;	r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r4);	return b1
;block_num 2