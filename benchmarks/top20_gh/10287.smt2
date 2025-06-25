(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3508 0)
(declare-sort var1754 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var3508 var3508)
(declare-const null-String String)
(declare-const var1799 var3508) ; Statement: r2 := @this: org.springframework.javapoet.CodeWriter 
(assert (not (= var1799 null-var3508)))
(declare-const var3975 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3975 null-String)))
(define-const var98 Bool (ite (= 1 1) true false)) ; Statement: z7 = 1 
(define-const var3867 Int (cast-from-Int-to-Int -1)) ; Statement: $i7 = (int) -1 
; split operation: var713 = var3975.split("\u005cR", var3867) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\R", $i7) 
(define-const var1308 Int (get_split_length var3975 "\u005cR" var3867)) ; Statement: i0 = lengthof r1 
(define-const var3706 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i0 goto return r2 
(assert (>= var3706 var1308)) ; Cond: i4 >= i0 
 ; Statement: return r2 
(check-sat)
; {cast-from-Int-to-Int=([int], int)}
; {var3508=org.springframework.javapoet.CodeWriter, var1799=r2, var3975=r0, var1754=null_type, var98=z7, var3867=$i7, var713=r1, var1308=i0, var3706=i4}
; {org.springframework.javapoet.CodeWriter=var3508, r2=var1799, r0=var3975, null_type=var1754, z7=var98, $i7=var3867, r1=var713, i0=var1308, i4=var3706}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r2 := @this: org.springframework.javapoet.CodeWriter;	r0 := @parameter0: java.lang.String;	z7 = 1;	$i7 = (int) -1;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\R", $i7);	i0 = lengthof r1;	i4 = 0;	if i4 >= i0 goto return r2;	return r2
;block_num 3