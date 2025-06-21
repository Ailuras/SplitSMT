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

(declare-sort var2550 0)
(declare-sort var2355 0)
(declare-sort var2695 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var2550 String) String)
(declare-fun var2695_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseByte/566405473 (String) Int)
(declare-const null-var2550 var2550)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2613 var2550) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2613 null-var2550)))
(declare-const var3005 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3005 null-String)))
(declare-const var3302 Int) ; Statement: b1 := @parameter1: byte 
(assert (not (= var3302 null-Int)))
(assert true)
(define-const var2792 String (getParameter/-1307325648 var2613 var3005)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var1546 Bool (var2695_isEmpty/-813097145 var2792)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r2) 
(assert (= (ite var1546 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2082 Int (Int_parseByte/566405473 var2792)) ; Statement: $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r2) 
 ; Statement: return $b0 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2695_isEmpty/-813097145=([java.lang.String], boolean), Int_parseByte/566405473=([java.lang.String], byte)}
; {var2550=org.apache.dubbo.common.URL, var2613=r0, var3005=r1, var2355=null_type, var3302=b1, var2792=r2, var2695=org.apache.dubbo.common.utils.StringUtils, var1546=$z0, var2082=$b0}
; {org.apache.dubbo.common.URL=var2550, r0=var2613, r1=var3005, null_type=var2355, b1=var3302, r2=var2792, org.apache.dubbo.common.utils.StringUtils=var2695, $z0=var1546, $b0=var2082}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	b1 := @parameter1: byte;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r2);	$b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r2);	return $b0
;block_num 2