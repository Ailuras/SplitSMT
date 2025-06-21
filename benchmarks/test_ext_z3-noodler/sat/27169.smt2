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

(declare-sort var3235 0)
(declare-sort var604 0)
(declare-sort var2575 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const String!class ClassObject)
(declare-fun var3235_getClass/1258963082 (var3235) ClassObject)
(declare-fun cast-from-String-to-var3235 (String) var3235)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun getBytes/-163691139 (String var604) (Array Int Int))
(declare-const null-String String)
(declare-const var2575-ISO_8859_1 var604)
(declare-const var86 String) ; Statement: r0 := @parameter0: java.lang.CharSequence 
(assert (not (= var86 null-String)))
(define-const var2540 ClassObject (var3235_getClass/1258963082 (cast-from-String-to-var3235 var86))) ; Statement: $r1 = interfaceinvoke r0.<java.lang.CharSequence: java.lang.Class getClass()>() 
 ; Statement: if $r1 != class "Ljava/lang/String;" goto i0 = interfaceinvoke r0.<java.lang.CharSequence: int length()>() 
(assert (not (not (= var2540 String!class)))) ; Negate: Cond: $r1 != class "Ljava/lang/String;"  
(define-const var1177 String (cast-from-String-to-String var86)) ; Statement: $r4 = (java.lang.String) r0 
(define-const var678 var604 var2575-ISO_8859_1) ; Statement: $r3 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset ISO_8859_1> 
(assert true)
(define-const var1546 (Array Int Int) (getBytes/-163691139 var1177 var678)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r3) 
 ; Statement: return $r5 
(check-sat)
; {var3235_getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-String-to-var3235=([java.lang.CharSequence], java.lang.Object), cast-from-String-to-String=([java.lang.CharSequence], java.lang.String), getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[])}
; {var86=r0, var3235=java.lang.Object, var2540=$r1, var1177=$r4, var604=java.nio.charset.Charset, var2575=java.nio.charset.StandardCharsets, var678=$r3, var1546=$r5}
; {r0=var86, java.lang.Object=var3235, $r1=var2540, $r4=var1177, java.nio.charset.Charset=var604, java.nio.charset.StandardCharsets=var2575, $r3=var678, $r5=var1546}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 1}
;stmts r0 := @parameter0: java.lang.CharSequence;	$r1 = interfaceinvoke r0.<java.lang.CharSequence: java.lang.Class getClass()>();	if $r1 != class "Ljava/lang/String;" goto i0 = interfaceinvoke r0.<java.lang.CharSequence: int length()>();	$r4 = (java.lang.String) r0;	$r3 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset ISO_8859_1>;	$r5 = virtualinvoke $r4.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r3);	return $r5
;block_num 2