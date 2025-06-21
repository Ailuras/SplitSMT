(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; ; 统一获取长度的函数
; (define-fun get_split_length ((x String) (d String) (limit Int)) Int
;   (ite
;     (> limit 0)
;     (ite (< (str.num_splits x d) limit)
;          (str.num_splits x d)
;          limit)
;     (str.num_splits x d)
;   )
; )

; ; 统一获取元素的函数
; (define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
;   (ite
;     (and (> limit 0)
;          (= i (- limit 1))
;          (>= (str.num_splits x d) limit))
;     (str.split_rest x d (- limit 1))
;     (str.split_at x d i)
;   )
; )

(declare-sort var49 0)
(declare-sort var1928 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toLowerCase/1946809429 (String var1928) String)
(define-fun replace/1524665721 ((s String) (old_char Int) (new_char Int)) String (str.replace_all s (str.from_code old_char) (str.from_code new_char)))
(declare-const null-String String)
(declare-const var1928-US var1928)
(declare-const var20 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var20 null-String)))
(define-const var2185 var1928 var1928-US) ; Statement: $r1 = <java.util.Locale: java.util.Locale US> 
(assert true)
(define-const var848 String (toLowerCase/1946809429 var20 var2185)) ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>($r1) 
(assert true)
(define-const var1979 String (replace/1524665721 var848 45 95)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String replace(char,char)>(45, 95) 
 ; Statement: return $r3 
(check-sat)
; {toLowerCase/1946809429=([java.lang.String, java.util.Locale], java.lang.String), replace/1524665721=([java.lang.String, char, char], java.lang.String)}
; {var20=r0, var49=null_type, var1928=java.util.Locale, var2185=$r1, var848=$r2, var1979=$r3}
; {r0=var20, null_type=var49, java.util.Locale=var1928, $r1=var2185, $r2=var848, $r3=var1979}
;seq <java.lang.String: java.lang.String toLowerCase(java.util.Locale)>;	<java.lang.String: java.lang.String replace(char,char)>
;cnt {"<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>": 1,"<java.lang.String: java.lang.String replace(char,char)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = <java.util.Locale: java.util.Locale US>;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>($r1);	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String replace(char,char)>(45, 95);	return $r3
;block_num 1