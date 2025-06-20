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

(declare-sort var432 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toString/-522406933 (var432) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-String String)
(declare-const null-var432 var432)
(declare-const var1089 String) ; Statement: r1 := @parameter0: java.lang.StringBuilder 
(assert (not (= var1089 null-String)))
(declare-const var1049 var432) ; Statement: r0 := @parameter1: java.lang.Object 
(assert (not (= var1049 null-var432)))
(assert true) ; Non Conditional
(assert true)
(define-const var1545 String (toString/-522406933 var1049)) ; Statement: r18 = virtualinvoke r0.<java.lang.Object: java.lang.String toString()>() 
(assert true) ; Non Conditional
(assert true)
;(assert (append/672562846 var1089 var1545)) ; Statement: virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r18) 
(declare-const var1089!1 String)
(assert (= var1089!1 (str.++ var1089 var1545)))
(assert true) ; Non Conditional
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {toString/-522406933=([java.lang.Object], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder)}
; {var1089=r1, var432=java.lang.Object, var1049=r0, var1545=r18}
; {r1=var1089, java.lang.Object=var432, r0=var1049, r18=var1545}
;seq <java.lang.Object: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.lang.StringBuilder;	r0 := @parameter1: java.lang.Object;	r18 = virtualinvoke r0.<java.lang.Object: java.lang.String toString()>();	virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r18);	goto [?= return];	return
;block_num 5