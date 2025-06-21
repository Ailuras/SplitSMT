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

(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun isArray/1369458484 (ClassObject) Bool)
(declare-fun isPrimitive/-473230874 (ClassObject) Bool)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun replace/1524665721 ((s String) (old_char Int) (new_char Int)) String (str.replace_all s (str.from_code old_char) (str.from_code new_char)))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-ClassObject ClassObject)
(declare-const var1530 ClassObject) ; Statement: r14 := @parameter0: java.lang.Class 
(assert (not (= var1530 null-ClassObject)))
(define-const var1321 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1321)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1321!1 String)
(assert (= var1321!1 ""))
(assert true) ; Non Conditional
(assert true)
(define-const var242 Bool (isArray/1369458484 var1530)) ; Statement: $z0 = virtualinvoke r14.<java.lang.Class: boolean isArray()>() 
 ; Statement: if $z0 == 0 goto $z1 = virtualinvoke r14.<java.lang.Class: boolean isPrimitive()>() 
(assert (= (ite var242 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1898 Bool (isPrimitive/-473230874 var1530)) ; Statement: $z1 = virtualinvoke r14.<java.lang.Class: boolean isPrimitive()>() 
 ; Statement: if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(76) 
(assert (= (ite var1898 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
;(assert (append/-1166366385 var1321!1 76)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(76) 
(declare-const var1321!2 String)
(assert (str.prefixof var1321!1 var1321!2))
(assert true)
(define-const var2490 String (getName/-1958580599 var1530)) ; Statement: $r1 = virtualinvoke r14.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3883 String (replace/1524665721 var2490 46 47)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.String: java.lang.String replace(char,char)>(46, 47) 
(assert true)
;(assert (append/672562846 var1321!2 var3883)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1321!3 String)
(assert (= var1321!3 (str.++ var1321!2 var3883)))
(assert true)
;(assert (append/-1166366385 var1321!3 59)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(59) 
(declare-const var1321!4 String)
(assert (str.prefixof var1321!3 var1321!4))
(assert true) ; Non Conditional
(assert true)
(define-const var3931 String (toString/-2075883882 var1321!4)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), isArray/1369458484=([java.lang.Class], boolean), isPrimitive/-473230874=([java.lang.Class], boolean), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getName/-1958580599=([java.lang.Class], java.lang.String), replace/1524665721=([java.lang.String, char, char], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1530=r14, var1321=$r0, var242=$z0, var1898=$z1, var2490=$r1, var3883=$r2, var3931=$r3}
; {r14=var1530, $r0=var1321, $z0=var242, $z1=var1898, $r1=var2490, $r2=var3883, $r3=var3931}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.String: java.lang.String replace(char,char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.String: java.lang.String replace(char,char)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r14 := @parameter0: java.lang.Class;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$z0 = virtualinvoke r14.<java.lang.Class: boolean isArray()>();	if $z0 == 0 goto $z1 = virtualinvoke r14.<java.lang.Class: boolean isPrimitive()>();	$z1 = virtualinvoke r14.<java.lang.Class: boolean isPrimitive()>();	if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(76);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(76);	$r1 = virtualinvoke r14.<java.lang.Class: java.lang.String getName()>();	$r2 = virtualinvoke $r1.<java.lang.String: java.lang.String replace(char,char)>(46, 47);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(59);	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 5