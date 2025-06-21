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

(declare-sort var1702 0)
(declare-sort var2153 0)
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
(declare-fun getMethod/1303228849 (ClassObject String (Array Int ClassObject)) var2153)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-var2153 var2153)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const var3624 ClassObject) ; Statement: r9 := @parameter0: java.lang.Class 
(assert (not (= var3624 null-ClassObject)))
(declare-const var1238 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1238 null-String)))
(declare-const var1332 ClassObject) ; Statement: r11 := @parameter2: java.lang.Class 
(assert (not (= var1332 null-ClassObject)))
(define-const var2353 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2353)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2353!1 String)
(assert (= var2353!1 ""))
(assert true)
(define-const var836 String (append/672562846 var2353!1 "set")) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("set") 
(declare-const var2353!2 String)
(assert (= var2353!2 (str.++ var2353!1 "set")))
(assert (and true (and (>= 0 0) (>= (str.len var1238) 1) (>= 1 0))))
(define-const var678 String (substring/-1240304868 var1238 0 1)) ; Statement: $r2 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int,int)>(0, 1) 
(assert true)
(define-const var289 String (toUpperCase/1156088314 var678)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toUpperCase()>() 
(assert true)
(define-const var3860 String (append/672562846 var836 var289)) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var836!1 String)
(assert (= var836!1 (str.++ var836 var289)))
(assert (and true (and (>= 1 0) (>= (str.len var1238) 1))))
(define-const var546 String (substring/850833817 var1238 1)) ; Statement: $r5 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int)>(1) 
(assert true)
(define-const var3798 String (append/672562846 var3860 var546)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3860!1 String)
(assert (= var3860!1 (str.++ var3860 var546)))
(assert true)
(define-const var3289 String (toString/-2075883882 var3798)) ; Statement: r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1349 var2153 null-var2153) ; Statement: r16 = null 
(define-const var1913 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r10 = newarray (java.lang.Class)[1] 
(declare-const var1913!1 (Array Int ClassObject))
(assert (not (= var1913!1 null-__Array__Int__ClassObject__)))
(assert (= (select var1913!1 0) var1332)) ; Statement: $r10[0] = r11 
(assert true) ; Non Conditional
(assert true)
(define-const var1349!1 var2153 (getMethod/1303228849 var3624 var3289 var1913!1)) ; Statement: r16 = virtualinvoke r9.<java.lang.Class: java.lang.reflect.Method getMethod(java.lang.String,java.lang.Class[])>(r8, $r10) 
(assert true) ; Non Conditional
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if r16 == null goto return r16 
(assert (= var1349!1 null-var2153)) ; Cond: r16 == null 
 ; Statement: return r16 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), substring/-1240304868=([java.lang.String, int, int], java.lang.String), toUpperCase/1156088314=([java.lang.String], java.lang.String), substring/850833817=([java.lang.String, int], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), arr-ClassObject-init=([], java.lang.Class[]), getMethod/1303228849=([java.lang.Class, java.lang.String, java.lang.Class[]], java.lang.reflect.Method)}
; {var3624=r9, var1238=r1, var1702=null_type, var1332=r11, var2353=$r0, var836=$r4, var678=$r2, var289=$r3, var3860=$r6, var546=$r5, var3798=$r7, var3289=r8, var2153=java.lang.reflect.Method, var1349=r16, var1913=$r10}
; {r9=var3624, r1=var1238, null_type=var1702, r11=var1332, $r0=var2353, $r4=var836, $r2=var678, $r3=var289, $r6=var3860, $r5=var546, $r7=var3798, r8=var3289, java.lang.reflect.Method=var2153, r16=var1349, $r10=var1913}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String toUpperCase()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String toUpperCase()>": 1,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @parameter0: java.lang.Class;	r1 := @parameter1: java.lang.String;	r11 := @parameter2: java.lang.Class;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("set");	$r2 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int,int)>(0, 1);	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toUpperCase()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int)>(1);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	r16 = null;	$r10 = newarray (java.lang.Class)[1];	$r10[0] = r11;	r16 = virtualinvoke r9.<java.lang.Class: java.lang.reflect.Method getMethod(java.lang.String,java.lang.Class[])>(r8, $r10);	goto [?= (branch)];	if r16 == null goto return r16;	return r16
;block_num 5