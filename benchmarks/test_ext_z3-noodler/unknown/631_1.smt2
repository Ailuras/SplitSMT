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

(declare-sort var1973 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun append/-1166366385 (String Int) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-String String)
(declare-const var2717 String) ; Statement: r0 := @parameter0: java.lang.StringBuilder 
(assert (not (= var2717 null-String)))
(declare-const var123 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var123 null-String)))
(declare-const var2899 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var2899 null-String)))
(assert true)
;(assert (append/-1166366385 var2717 38)) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(38) 
(declare-const var2717!1 String)
(assert (str.prefixof var2717 var2717!1))
(assert true)
;(assert (append/672562846 var2717!1 var123)) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var2717!2 String)
(assert (= var2717!2 (str.++ var2717!1 var123)))
(assert true)
;(assert (append/-1166366385 var2717!2 61)) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(61) 
(declare-const var2717!3 String)
(assert (str.prefixof var2717!2 var2717!3))
(assert true)
;(assert (append/672562846 var2717!3 var2899)) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2717!4 String)
(assert (= var2717!4 (str.++ var2717!3 var2899)))
 ; Statement: return 
(check-sat)
; {append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder)}
; {var2717=r0, var123=r1, var1973=null_type, var2899=r2}
; {r0=var2717, r1=var123, null_type=var1973, r2=var2899}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2}
;stmts r0 := @parameter0: java.lang.StringBuilder;	r1 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(38);	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(61);	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	return
;block_num 1