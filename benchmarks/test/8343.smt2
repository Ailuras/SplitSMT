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

(declare-sort var1300 0)
(declare-sort var3355 0)
(declare-sort var1859 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1859_isEmpty/-813097145 (String) Bool)
(declare-fun arr-String-init () (Array Int String))
(declare-fun removeParameters/1564489036 (var1300 (Array Int String)) var1300)
(declare-const null-var1300 var1300)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3593 var1300) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3593 null-var1300)))
(declare-const var1083 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1083 null-String)))
(define-const var253 Bool (var1859_isEmpty/-813097145 var1083)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = newarray (java.lang.String)[1] 
(assert (= (ite var253 1 0) 0)) ; Cond: $z0 == 0 
(define-const var866 (Array Int String) arr-String-init) ; Statement: $r2 = newarray (java.lang.String)[1] 
(declare-const var866!1 (Array Int String))
(assert (not (= var866!1 null-__Array__Int__String__)))
(assert (= (select var866!1 0) var1083)) ; Statement: $r2[0] = r0 
(assert true)
(define-const var2 var1300 (removeParameters/1564489036 var3593 var866!1)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameters(java.lang.String[])>($r2) 
 ; Statement: return $r3 
(check-sat)
; {var1859_isEmpty/-813097145=([java.lang.String], boolean), arr-String-init=([], java.lang.String[]), removeParameters/1564489036=([org.apache.dubbo.common.URL, java.lang.String[]], org.apache.dubbo.common.URL)}
; {var1300=org.apache.dubbo.common.URL, var3593=r1, var1083=r0, var3355=null_type, var1859=org.apache.dubbo.common.utils.StringUtils, var253=$z0, var866=$r2, var2=$r3}
; {org.apache.dubbo.common.URL=var1300, r1=var3593, r0=var1083, null_type=var3355, org.apache.dubbo.common.utils.StringUtils=var1859, $z0=var253, $r2=var866, $r3=var2}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = newarray (java.lang.String)[1];	$r2 = newarray (java.lang.String)[1];	$r2[0] = r0;	$r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameters(java.lang.String[])>($r2);	return $r3
;block_num 2