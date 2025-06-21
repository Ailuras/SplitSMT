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

(declare-sort var989 0)
(declare-sort var2245 0)
(declare-sort var3894 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun toUpperCase/1156088314 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun getMethods/-297347657 (ClassObject) (Array Int var2245))
(declare-fun getLength-Arr-var2245-1 ((Array Int var2245)) Int)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-var2245 var2245)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-var3894 var3894)
(declare-const var2274 ClassObject) ; Statement: r9 := @parameter0: java.lang.Class 
(assert (not (= var2274 null-ClassObject)))
(declare-const var997 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var997 null-String)))
(declare-const var1945 ClassObject) ; Statement: r11 := @parameter2: java.lang.Class 
(assert (not (= var1945 null-ClassObject)))
(define-const var2630 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2630)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2630!1 String)
(assert (= var2630!1 ""))
(assert true)
(define-const var3363 String (append/672562846 var2630!1 "set")) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("set") 
(declare-const var2630!2 String)
(assert (= var2630!2 (str.++ var2630!1 "set")))
(assert (and true (and (>= 0 0) (>= (str.len var997) 1) (>= 1 0))))
(define-const var1336 String (substring/-1240304868 var997 0 1)) ; Statement: $r2 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int,int)>(0, 1) 
(assert true)
(define-const var3841 String (toUpperCase/1156088314 var1336)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toUpperCase()>() 
(assert true)
(define-const var2300 String (append/672562846 var3363 var3841)) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var3363!1 String)
(assert (= var3363!1 (str.++ var3363 var3841)))
(assert (not (and true (and (>= 1 0) (>= (str.len var997) 1)))))
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), substring/-1240304868=([java.lang.String, int, int], java.lang.String), toUpperCase/1156088314=([java.lang.String], java.lang.String), substring/850833817=([java.lang.String, int], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), arr-ClassObject-init=([], java.lang.Class[]), getMethods/-297347657=([java.lang.Class], java.lang.reflect.Method[]), getLength-Arr-var2245-1=([java.lang.reflect.Method[]], int)}
; {var2274=r9, var997=r1, var989=null_type, var1945=r11, var2630=$r0, var3363=$r4, var1336=$r2, var3841=$r3, var2300=$r6, var299=$r5, var609=$r7, var80=r8, var2245=java.lang.reflect.Method, var3693=r16, var1687=$r10, var3894=java.lang.NoSuchMethodException, var2962=$r12, var1463=r13, var3050=i0, var3442=i1}
; {r9=var2274, r1=var997, null_type=var989, r11=var1945, $r0=var2630, $r4=var3363, $r2=var1336, $r3=var3841, $r6=var2300, $r5=var299, $r7=var609, r8=var80, java.lang.reflect.Method=var2245, r16=var3693, $r10=var1687, java.lang.NoSuchMethodException=var3894, $r12=var2962, r13=var1463, i0=var3050, i1=var3442}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String toUpperCase()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String toUpperCase()>": 1,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @parameter0: java.lang.Class;	r1 := @parameter1: java.lang.String;	r11 := @parameter2: java.lang.Class;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("set");	$r2 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int,int)>(0, 1);	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toUpperCase()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int)>(1);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	r16 = null;	$r10 = newarray (java.lang.Class)[1];	$r10[0] = r11;	$r12 := @caughtexception;	r13 = virtualinvoke r9.<java.lang.Class: java.lang.reflect.Method[] getMethods()>();	i0 = lengthof r13;	i1 = 0;	if i1 >= i0 goto (branch);	if r16 == null goto return r16;	return r16
;block_num 5