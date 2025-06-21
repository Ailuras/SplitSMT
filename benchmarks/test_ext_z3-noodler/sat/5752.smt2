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

(declare-sort var2866 0)
(declare-sort var3653 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3653_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var1396 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1396 null-String)))
(declare-const var2677 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2677 null-String)))
(define-const var295 Bool (var3653_isEmpty/-813097145 var1396)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = "*" 
(assert (= (ite var295 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2369 String "*") ; Statement: $r1 = "*" 
(assert true)
(define-const var1696 Bool (= var2369 var1396)) ; Statement: $z1 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z1 != 0 goto $z4 = 1 
(assert (not (= (ite var1696 1 0) 0))) ; Cond: $z1 != 0 
(define-const var2099 Bool (ite (= 1 1) true false)) ; Statement: $z4 = 1 
 ; Statement: goto [?= return $z4] 
(assert true) ; Non Conditional
 ; Statement: return $z4 
(check-sat)
; {var3653_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1396=r0, var2866=null_type, var2677=r2, var3653=org.apache.dubbo.common.utils.StringUtils, var295=$z0, var2369=$r1, var1696=$z1, var2099=$z4}
; {r0=var1396, null_type=var2866, r2=var2677, org.apache.dubbo.common.utils.StringUtils=var3653, $z0=var295, $r1=var2369, $z1=var1696, $z4=var2099}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = "*";	$r1 = "*";	$z1 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z1 != 0 goto $z4 = 1;	$z4 = 1;	goto [?= return $z4];	return $z4
;block_num 4