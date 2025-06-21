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

(declare-sort var2273 0)
(declare-sort var1715 0)
(declare-sort var3554 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var2273 String) String)
(declare-fun var3554_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseShort/65208931 (String) Int)
(declare-const null-var2273 var2273)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3420 var2273) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3420 null-var2273)))
(declare-const var3126 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3126 null-String)))
(declare-const var3195 Int) ; Statement: s1 := @parameter1: short 
(assert (not (= var3195 null-Int)))
(assert true)
(define-const var2888 String (getParameter/-1307325648 var3420 var3126)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var3021 Bool (var3554_isEmpty/-813097145 var2888)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r2) 
(assert (= (ite var3021 1 0) 0)) ; Cond: $z0 == 0 
(define-const var191 Int (Int_parseShort/65208931 var2888)) ; Statement: $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r2) 
 ; Statement: return $s0 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3554_isEmpty/-813097145=([java.lang.String], boolean), Int_parseShort/65208931=([java.lang.String], short)}
; {var2273=org.apache.dubbo.common.URL, var3420=r0, var3126=r1, var1715=null_type, var3195=s1, var2888=r2, var3554=org.apache.dubbo.common.utils.StringUtils, var3021=$z0, var191=$s0}
; {org.apache.dubbo.common.URL=var2273, r0=var3420, r1=var3126, null_type=var1715, s1=var3195, r2=var2888, org.apache.dubbo.common.utils.StringUtils=var3554, $z0=var3021, $s0=var191}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	s1 := @parameter1: short;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r2);	$s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r2);	return $s0
;block_num 2