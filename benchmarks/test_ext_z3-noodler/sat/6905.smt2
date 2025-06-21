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

(declare-sort var131 0)
(declare-sort var669 0)
(declare-sort var2133 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2015795402 (var131 String String) String)
(declare-fun var2133_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseByte/566405473 (String) Int)
(declare-const null-var131 var131)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1466 var131) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1466 null-var131)))
(declare-const var3741 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3741 null-String)))
(declare-const var220 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var220 null-String)))
(declare-const var839 Int) ; Statement: b1 := @parameter2: byte 
(assert (not (= var839 null-Int)))
(assert true)
(define-const var2954 String (getMethodParameter/2015795402 var1466 var3741 var220)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var309 Bool (var2133_isEmpty/-813097145 var2954)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r3) 
(assert (= (ite var309 1 0) 0)) ; Cond: $z0 == 0 
(define-const var947 Int (Int_parseByte/566405473 var2954)) ; Statement: $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r3) 
 ; Statement: return $b0 
(check-sat)
; {getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var2133_isEmpty/-813097145=([java.lang.String], boolean), Int_parseByte/566405473=([java.lang.String], byte)}
; {var131=org.apache.dubbo.common.URL, var1466=r0, var3741=r1, var669=null_type, var220=r2, var839=b1, var2954=r3, var2133=org.apache.dubbo.common.utils.StringUtils, var309=$z0, var947=$b0}
; {org.apache.dubbo.common.URL=var131, r0=var1466, r1=var3741, null_type=var669, r2=var220, b1=var839, r3=var2954, org.apache.dubbo.common.utils.StringUtils=var2133, $z0=var309, $b0=var947}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	b1 := @parameter2: byte;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r3);	$b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r3);	return $b0
;block_num 2