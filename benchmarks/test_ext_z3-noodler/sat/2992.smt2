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

(declare-sort var527 0)
(declare-sort var1624 0)
(declare-sort var2936 0)
(declare-sort var2874 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2874!class ClassObject)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun arr-var2936-init () (Array Int var2936))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var2936 (Int) var2936)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun cast-from-String-to-var2936 (String) var2936)
(declare-fun String_format/1339386452 (String (Array Int var2936)) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var527 var527)
(declare-const null-Int Int)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-__Array__Int__var2936__ (Array Int var2936))
(declare-const var393 var527) ; Statement: r17 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var393 null-var527)))
(declare-const var3743 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var3743 null-Int)))
(declare-const var1080 ClassObject) ; Statement: r3 := @parameter1: java.lang.Class 
(assert (not (= var1080 null-ClassObject)))
(declare-const var2996 String) ; Statement: r8 := @parameter2: java.lang.String 
(assert (not (= var2996 null-String)))
(define-const var62 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var62)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var62!1 String)
(assert (= var62!1 ""))
(define-const var2455 (Array Int var2936) arr-var2936-init) ; Statement: $r1 = newarray (java.lang.Object)[2] 
(define-const var215 Int (Int_valueOf/-1371140006 var3743)) ; Statement: $r2 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var2455!1 (Array Int var2936))
(assert (not (= var2455!1 null-__Array__Int__var2936__)))
(assert (= (select var2455!1 0) (cast-from-Int-to-var2936 var215))) ; Statement: $r1[0] = $r2 
(assert true)
(define-const var924 String (getName/-1958580599 var1080)) ; Statement: $r4 = virtualinvoke r3.<java.lang.Class: java.lang.String getName()>() 
(declare-const var2455!2 (Array Int var2936))
(assert (not (= var2455!2 null-__Array__Int__var2936__)))
(assert (= (select var2455!2 1) (cast-from-String-to-var2936 var924))) ; Statement: $r1[1] = $r4 
(define-const var2197 String (String_format/1339386452 "if (arg%d == null) throw new IllegalArgumentException(\u0022%s argument == null\u0022);\n" var2455!2)) ; Statement: $r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("if (arg%d == null) throw new IllegalArgumentException(\"%s argument == null\");\n", $r1) 
(assert true)
;(assert (append/672562846 var62!1 var2197)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var62!2 String)
(assert (= var62!2 (str.++ var62!1 var2197)))
(define-const var818 (Array Int var2936) arr-var2936-init) ; Statement: $r6 = newarray (java.lang.Object)[4] 
(define-const var748 Int (Int_valueOf/-1371140006 var3743)) ; Statement: $r7 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var818!1 (Array Int var2936))
(assert (not (= var818!1 null-__Array__Int__var2936__)))
(assert (= (select var818!1 0) (cast-from-Int-to-var2936 var748))) ; Statement: $r6[0] = $r7 
(declare-const var818!2 (Array Int var2936))
(assert (not (= var818!2 null-__Array__Int__var2936__)))
(assert (= (select var818!2 1) (cast-from-String-to-var2936 var2996))) ; Statement: $r6[1] = r8 
(assert true)
(define-const var363 String (getName/-1958580599 var1080)) ; Statement: $r9 = virtualinvoke r3.<java.lang.Class: java.lang.String getName()>() 
(declare-const var818!3 (Array Int var2936))
(assert (not (= var818!3 null-__Array__Int__var2936__)))
(assert (= (select var818!3 2) (cast-from-String-to-var2936 var363))) ; Statement: $r6[2] = $r9 
(declare-const var818!4 (Array Int var2936))
(assert (not (= var818!4 null-__Array__Int__var2936__)))
(assert (= (select var818!4 3) (cast-from-String-to-var2936 var2996))) ; Statement: $r6[3] = r8 
(define-const var2797 String (String_format/1339386452 "if (arg%d.%s() == null) throw new IllegalArgumentException(\u0022%s argument %s() == null\u0022);\n" var818!4)) ; Statement: $r10 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("if (arg%d.%s() == null) throw new IllegalArgumentException(\"%s argument %s() == null\");\n", $r6) 
(assert true)
;(assert (append/672562846 var62!2 var2797)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var62!3 String)
(assert (= var62!3 (str.++ var62!2 var2797)))
(define-const var1520 (Array Int var2936) arr-var2936-init) ; Statement: $r11 = newarray (java.lang.Object)[3] 
(define-const var2684 ClassObject var2874!class) ; Statement: $r12 = class "Lorg/apache/dubbo/common/URL;" 
(assert true)
(define-const var2415 String (getName/-1958580599 var2684)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.Class: java.lang.String getName()>() 
(declare-const var1520!1 (Array Int var2936))
(assert (not (= var1520!1 null-__Array__Int__var2936__)))
(assert (= (select var1520!1 0) (cast-from-String-to-var2936 var2415))) ; Statement: $r11[0] = $r13 
(define-const var398 Int (Int_valueOf/-1371140006 var3743)) ; Statement: $r14 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var1520!2 (Array Int var2936))
(assert (not (= var1520!2 null-__Array__Int__var2936__)))
(assert (= (select var1520!2 1) (cast-from-Int-to-var2936 var398))) ; Statement: $r11[1] = $r14 
(declare-const var1520!3 (Array Int var2936))
(assert (not (= var1520!3 null-__Array__Int__var2936__)))
(assert (= (select var1520!3 2) (cast-from-String-to-var2936 var2996))) ; Statement: $r11[2] = r8 
(define-const var816 String (String_format/1339386452 "%s url = arg%d.%s();\n" var1520!3)) ; Statement: $r15 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%s url = arg%d.%s();\n", $r11) 
(assert true)
;(assert (append/672562846 var62!3 var816)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var62!4 String)
(assert (= var62!4 (str.++ var62!3 var816)))
(assert true)
(define-const var2112 String (toString/-2075883882 var62!4)) ; Statement: $r16 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r16 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), arr-var2936-init=([], java.lang.Object[]), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var2936=([java.lang.Integer], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), cast-from-String-to-var2936=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var527=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var393=r17, var3743=i0, var1080=r3, var2996=r8, var1624=null_type, var62=$r0, var2936=java.lang.Object, var2455=$r1, var215=$r2, var924=$r4, var2197=$r5, var818=$r6, var748=$r7, var363=$r9, var2797=$r10, var1520=$r11, var2874=org.apache.dubbo.common.URL, var2684=$r12, var2415=$r13, var398=$r14, var816=$r15, var2112=$r16}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var527, r17=var393, i0=var3743, r3=var1080, r8=var2996, null_type=var1624, $r0=var62, java.lang.Object=var2936, $r1=var2455, $r2=var215, $r4=var924, $r5=var2197, $r6=var818, $r7=var748, $r9=var363, $r10=var2797, $r11=var1520, org.apache.dubbo.common.URL=var2874, $r12=var2684, $r13=var2415, $r14=var398, $r15=var816, $r16=var2112}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r17 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	i0 := @parameter0: int;	r3 := @parameter1: java.lang.Class;	r8 := @parameter2: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r1 = newarray (java.lang.Object)[2];	$r2 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r1[0] = $r2;	$r4 = virtualinvoke r3.<java.lang.Class: java.lang.String getName()>();	$r1[1] = $r4;	$r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("if (arg%d == null) throw new IllegalArgumentException(\"%s argument == null\");\n", $r1);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r6 = newarray (java.lang.Object)[4];	$r7 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r6[0] = $r7;	$r6[1] = r8;	$r9 = virtualinvoke r3.<java.lang.Class: java.lang.String getName()>();	$r6[2] = $r9;	$r6[3] = r8;	$r10 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("if (arg%d.%s() == null) throw new IllegalArgumentException(\"%s argument %s() == null\");\n", $r6);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r11 = newarray (java.lang.Object)[3];	$r12 = class "Lorg/apache/dubbo/common/URL;";	$r13 = virtualinvoke $r12.<java.lang.Class: java.lang.String getName()>();	$r11[0] = $r13;	$r14 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r11[1] = $r14;	$r11[2] = r8;	$r15 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%s url = arg%d.%s();\n", $r11);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r16 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r16
;block_num 1