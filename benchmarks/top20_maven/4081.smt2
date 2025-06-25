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

(declare-sort var2133 0)
(declare-sort var3389 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun render/1206271498 (var2133 String String (Array Int String)) void)
(declare-const null-var2133 var2133)
(declare-const null-String String)
(declare-const var546 var2133) ; Statement: r0 := @this: org.apache.logging.log4j.core.pattern.AnsiTextRenderer 
(assert (not (= var546 null-var2133)))
(declare-const var271 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var271 null-String)))
(declare-const var3919 String) ; Statement: r2 := @parameter1: java.lang.StringBuilder 
(assert (not (= var3919 null-String)))
(declare-const var810 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var810 null-String)))
(define-const var152 Int (cast-from-Int-to-Int -1)) ; Statement: $i1 = (int) -1 
; split operation: var2028 = var810.split(",", var152) ; Statement: $r4 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(",", $i1) 
(assert true)
;(assert (render/1206271498 var546 var271 var3919 var2028)) ; Statement: virtualinvoke r0.<org.apache.logging.log4j.core.pattern.AnsiTextRenderer: void render(java.lang.String,java.lang.StringBuilder,java.lang.String[])>(r1, r2, $r4) 

(declare-const var546!1 var2133)
(declare-const var271!1 String)
(declare-const var3919!1 String)
(declare-const var2028!1 (Array Int String))
 ; Statement: return 
(check-sat)
; {cast-from-Int-to-Int=([int], int), render/1206271498=([org.apache.logging.log4j.core.pattern.AnsiTextRenderer, java.lang.String, java.lang.StringBuilder, java.lang.String[]], void)}
; {var2133=org.apache.logging.log4j.core.pattern.AnsiTextRenderer, var546=r0, var271=r1, var3389=null_type, var3919=r2, var810=r3, var152=$i1, var2028=$r4}
; {org.apache.logging.log4j.core.pattern.AnsiTextRenderer=var2133, r0=var546, r1=var271, null_type=var3389, r2=var3919, r3=var810, $i1=var152, $r4=var2028}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @this: org.apache.logging.log4j.core.pattern.AnsiTextRenderer;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.StringBuilder;	r3 := @parameter2: java.lang.String;	$i1 = (int) -1;	$r4 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(",", $i1);	virtualinvoke r0.<org.apache.logging.log4j.core.pattern.AnsiTextRenderer: void render(java.lang.String,java.lang.StringBuilder,java.lang.String[])>(r1, r2, $r4);	return
;block_num 1