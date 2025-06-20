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

(declare-sort var5 0)
(declare-sort var3642 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun var3642_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var2655 String) ; Statement: r7 := @parameter0: java.lang.String 
(assert (not (= var2655 null-String)))
(assert true)
(define-const var995 Int (indexOf/-1037706067 var2655 33)) ; Statement: $i0 = virtualinvoke r7.<java.lang.String: int indexOf(int)>(33) 
 ; Statement: if $i0 != 0 goto z4 = 0 
(assert (not (not (= var995 0)))) ; Negate: Cond: $i0 != 0  
(define-const var1187 Bool (ite (= 1 1) true false)) ; Statement: z4 = 1 
(assert (and true (and (>= 1 0) (>= (str.len var2655) 1))))
(define-const var2655!1 String (substring/850833817 var2655 1)) ; Statement: r7 = virtualinvoke r7.<java.lang.String: java.lang.String substring(int)>(1) 
 ; Statement: goto [?= $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r7)] 
(assert true) ; Non Conditional
(define-const var612 Bool (var3642_isEmpty/-813097145 var2655!1)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r7) 
 ; Statement: if $z0 == 0 goto i1 = virtualinvoke r7.<java.lang.String: int indexOf(int)>(59) 
(assert (not (= (ite var612 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return null 
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), substring/850833817=([java.lang.String, int], java.lang.String), var3642_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2655=r7, var5=null_type, var995=$i0, var1187=z4, var3642=org.apache.dubbo.common.utils.StringUtils, var612=$z0}
; {r7=var2655, null_type=var5, $i0=var995, z4=var1187, org.apache.dubbo.common.utils.StringUtils=var3642, $z0=var612}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: java.lang.String substring(int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r7 := @parameter0: java.lang.String;	$i0 = virtualinvoke r7.<java.lang.String: int indexOf(int)>(33);	if $i0 != 0 goto z4 = 0;	z4 = 1;	r7 = virtualinvoke r7.<java.lang.String: java.lang.String substring(int)>(1);	goto [?= $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r7)];	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r7);	if $z0 == 0 goto i1 = virtualinvoke r7.<java.lang.String: int indexOf(int)>(59);	return null
;block_num 4