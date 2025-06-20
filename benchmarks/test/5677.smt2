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

(declare-sort var174 0)
(declare-sort var3564 0)
(declare-sort var1252 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var1252-init () var1252)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1087086210 (var1252 String) void)
(declare-const null-var174 var174)
(declare-const null-String String)
(declare-const var1335 var174) ; Statement: r16 := @parameter0: java.lang.ClassLoader 
(assert (not (= var1335 null-var174)))
(declare-const var2961 String) ; Statement: r17 := @parameter1: java.lang.String 
(assert (not (= var2961 null-String)))
(assert (and true (and (> (str.len var2961) 0) (<= 0 0))))
(define-const var710 Int (charAt/698050440 var2961 0)) ; Statement: $c0 = virtualinvoke r17.<java.lang.String: char charAt(int)>(0) 
(define-const var145 Int (cast-from-Int-to-Int var710)) ; Statement: $i3 = (int) $c0 
 ; Statement: tableswitch($i3) {     case 66: goto $r10 = <java.lang.Byte: java.lang.Class TYPE>;     case 67: goto $r9 = <java.lang.Character: java.lang.Class TYPE>;     case 68: goto $r8 = <java.lang.Double: java.lang.Class TYPE>;     case 69: goto $r20 = new java.lang.ClassNotFoundException;     case 70: goto $r7 = <java.lang.Float: java.lang.Class TYPE>;     case 71: goto $r20 = new java.lang.ClassNotFoundException;     case 72: goto $r20 = new java.lang.ClassNotFoundException;     case 73: goto $r6 = <java.lang.Integer: java.lang.Class TYPE>;     case 74: goto $r5 = <java.lang.Long: java.lang.Class TYPE>;     case 75: goto $r20 = new java.lang.ClassNotFoundException;     case 76: goto $i1 = virtualinvoke r17.<java.lang.String: int length()>();     case 77: goto $r20 = new java.lang.ClassNotFoundException;     case 78: goto $r20 = new java.lang.ClassNotFoundException;     case 79: goto $r20 = new java.lang.ClassNotFoundException;     case 80: goto $r20 = new java.lang.ClassNotFoundException;     case 81: goto $r20 = new java.lang.ClassNotFoundException;     case 82: goto $r20 = new java.lang.ClassNotFoundException;     case 83: goto $r3 = <java.lang.Short: java.lang.Class TYPE>;     case 84: goto $r20 = new java.lang.ClassNotFoundException;     case 85: goto $r20 = new java.lang.ClassNotFoundException;     case 86: goto $r2 = <java.lang.Void: java.lang.Class TYPE>;     case 87: goto $r20 = new java.lang.ClassNotFoundException;     case 88: goto $r20 = new java.lang.ClassNotFoundException;     case 89: goto $r20 = new java.lang.ClassNotFoundException;     case 90: goto $r1 = <java.lang.Boolean: java.lang.Class TYPE>;     case 91: goto r18 = virtualinvoke r17.<java.lang.String: java.lang.String replace(char,char)>(47, 46);     default: goto $r20 = new java.lang.ClassNotFoundException; } 
(assert (and (not (= var145 68)) (and (not (= var145 67)) (and (not (= var145 66)) true)))) ; Intersect: Negate: Cond: $i3 == 68   and Intersect: Negate: Cond: $i3 == 67   and Intersect: Negate: Cond: $i3 == 66   and Non Conditional   
(define-const var3641 var1252 var1252-init) ; Statement: $r20 = new java.lang.ClassNotFoundException 
(define-const var483 String String-init) ; Statement: $r19 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var483)) ; Statement: specialinvoke $r19.<java.lang.StringBuilder: void <init>()>() 
(declare-const var483!1 String)
(assert (= var483!1 ""))
(assert true)
(define-const var2433 String (append/672562846 var483!1 "Class not found: ")) ; Statement: $r13 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Class not found: ") 
(declare-const var483!2 String)
(assert (= var483!2 (str.++ var483!1 "Class not found: ")))
(assert true)
(define-const var3469 String (append/672562846 var2433 var2961)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r17) 
(declare-const var2433!1 String)
(assert (= var2433!1 (str.++ var2433 var2961)))
(assert true)
(define-const var1024 String (toString/-2075883882 var3469)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1087086210 var3641 var1024)) ; Statement: specialinvoke $r20.<java.lang.ClassNotFoundException: void <init>(java.lang.String)>($r15) 

(declare-const var3641!1 var1252)
(declare-const var1024!1 String)
 ; Statement: throw $r20 
(check-sat)
; {charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int), var1252-init=([], java.lang.ClassNotFoundException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1087086210=([java.lang.ClassNotFoundException, java.lang.String], void)}
; {var174=java.lang.ClassLoader, var1335=r16, var2961=r17, var3564=null_type, var710=$c0, var145=$i3, var1252=java.lang.ClassNotFoundException, var3641=$r20, var483=$r19, var2433=$r13, var3469=$r14, var1024=$r15}
; {java.lang.ClassLoader=var174, r16=var1335, r17=var2961, null_type=var3564, $c0=var710, $i3=var145, java.lang.ClassNotFoundException=var1252, $r20=var3641, $r19=var483, $r13=var2433, $r14=var3469, $r15=var1024}
;seq <java.lang.String: char charAt(int)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: char charAt(int)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r16 := @parameter0: java.lang.ClassLoader;	r17 := @parameter1: java.lang.String;	$c0 = virtualinvoke r17.<java.lang.String: char charAt(int)>(0);	$i3 = (int) $c0;	tableswitch($i3) {     case 66: goto $r10 = <java.lang.Byte: java.lang.Class TYPE>;     case 67: goto $r9 = <java.lang.Character: java.lang.Class TYPE>;     case 68: goto $r8 = <java.lang.Double: java.lang.Class TYPE>;     case 69: goto $r20 = new java.lang.ClassNotFoundException;     case 70: goto $r7 = <java.lang.Float: java.lang.Class TYPE>;     case 71: goto $r20 = new java.lang.ClassNotFoundException;     case 72: goto $r20 = new java.lang.ClassNotFoundException;     case 73: goto $r6 = <java.lang.Integer: java.lang.Class TYPE>;     case 74: goto $r5 = <java.lang.Long: java.lang.Class TYPE>;     case 75: goto $r20 = new java.lang.ClassNotFoundException;     case 76: goto $i1 = virtualinvoke r17.<java.lang.String: int length()>();     case 77: goto $r20 = new java.lang.ClassNotFoundException;     case 78: goto $r20 = new java.lang.ClassNotFoundException;     case 79: goto $r20 = new java.lang.ClassNotFoundException;     case 80: goto $r20 = new java.lang.ClassNotFoundException;     case 81: goto $r20 = new java.lang.ClassNotFoundException;     case 82: goto $r20 = new java.lang.ClassNotFoundException;     case 83: goto $r3 = <java.lang.Short: java.lang.Class TYPE>;     case 84: goto $r20 = new java.lang.ClassNotFoundException;     case 85: goto $r20 = new java.lang.ClassNotFoundException;     case 86: goto $r2 = <java.lang.Void: java.lang.Class TYPE>;     case 87: goto $r20 = new java.lang.ClassNotFoundException;     case 88: goto $r20 = new java.lang.ClassNotFoundException;     case 89: goto $r20 = new java.lang.ClassNotFoundException;     case 90: goto $r1 = <java.lang.Boolean: java.lang.Class TYPE>;     case 91: goto r18 = virtualinvoke r17.<java.lang.String: java.lang.String replace(char,char)>(47, 46);     default: goto $r20 = new java.lang.ClassNotFoundException; };	$r20 = new java.lang.ClassNotFoundException;	$r19 = new java.lang.StringBuilder;	specialinvoke $r19.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Class not found: ");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r17);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r20.<java.lang.ClassNotFoundException: void <init>(java.lang.String)>($r15);	throw $r20
;block_num 2