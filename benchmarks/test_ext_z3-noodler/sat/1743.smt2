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

(declare-sort var1275 0)
(declare-sort var3608 0)
(declare-sort var2858 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3608_currentThread/-1037784612 () var3608)
(declare-fun getContextClassLoader/1719676180 (var3608) var2858)
(declare-fun ClassObject_forName/696536127 (String Bool var2858) ClassObject)
(declare-const null-String String)
(declare-const var3854 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3854 null-String)))
(assert true)
(define-const var3292 Bool (endsWith/985337093 var3854 "[]")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean endsWith(java.lang.String)>("[]") 
 ; Statement: if $z0 == 0 goto $r9 = r0 
(assert (not (= (ite var3292 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2687 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2687)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2687!1 String)
(assert (= var2687!1 ""))
(assert true)
(define-const var2340 String (append/672562846 var2687!1 "[L")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[L") 
(declare-const var2687!2 String)
(assert (= var2687!2 (str.++ var2687!1 "[L")))
(assert true)
(define-const var935 Int (length/-134980193 var3854)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var2247 Int (- var935 2)) ; Statement: $i1 = $i0 - 2 
(assert (and true (and (>= 0 0) (>= (str.len var3854) var2247) (>= var2247 0))))
(define-const var3369 String (substring/-1240304868 var3854 0 var2247)) ; Statement: $r5 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, $i1) 
(assert true)
(define-const var593 String (append/672562846 var2340 var3369)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2340!1 String)
(assert (= var2340!1 (str.++ var2340 var3369)))
(assert true)
(define-const var2151 String (append/672562846 var593 ";")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(";") 
(declare-const var593!1 String)
(assert (= var593!1 (str.++ var593 ";")))
(assert true)
(define-const var1433 String (toString/-2075883882 var2151)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: goto [?= $r1 = staticinvoke <java.lang.Thread: java.lang.Thread currentThread()>()] 
(assert true) ; Non Conditional
(define-const var992 var3608 var3608_currentThread/-1037784612) ; Statement: $r1 = staticinvoke <java.lang.Thread: java.lang.Thread currentThread()>() 
(assert true)
(define-const var3182 var2858 (getContextClassLoader/1719676180 var992)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.Thread: java.lang.ClassLoader getContextClassLoader()>() 
(define-const var2368 ClassObject (ClassObject_forName/696536127 var1433 (ite (= 1 1) true false) var3182)) ; Statement: $r3 = staticinvoke <java.lang.Class: java.lang.Class forName(java.lang.String,boolean,java.lang.ClassLoader)>($r9, 1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {endsWith/985337093=([java.lang.String, java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3608_currentThread/-1037784612=([], java.lang.Thread), getContextClassLoader/1719676180=([java.lang.Thread], java.lang.ClassLoader), ClassObject_forName/696536127=([java.lang.String, boolean, java.lang.ClassLoader], java.lang.Class)}
; {var3854=r0, var1275=null_type, var3292=$z0, var2687=$r4, var2340=$r6, var935=$i0, var2247=$i1, var3369=$r5, var593=$r7, var2151=$r8, var1433=$r9, var3608=java.lang.Thread, var992=$r1, var2858=java.lang.ClassLoader, var3182=$r2, var2368=$r3}
; {r0=var3854, null_type=var1275, $z0=var3292, $r4=var2687, $r6=var2340, $i0=var935, $i1=var2247, $r5=var3369, $r7=var593, $r8=var2151, $r9=var1433, java.lang.Thread=var3608, $r1=var992, java.lang.ClassLoader=var2858, $r2=var3182, $r3=var2368}
;seq <java.lang.String: boolean endsWith(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean endsWith(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean endsWith(java.lang.String)>("[]");	if $z0 == 0 goto $r9 = r0;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[L");	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	$i1 = $i0 - 2;	$r5 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, $i1);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(";");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	goto [?= $r1 = staticinvoke <java.lang.Thread: java.lang.Thread currentThread()>()];	$r1 = staticinvoke <java.lang.Thread: java.lang.Thread currentThread()>();	$r2 = virtualinvoke $r1.<java.lang.Thread: java.lang.ClassLoader getContextClassLoader()>();	$r3 = staticinvoke <java.lang.Class: java.lang.Class forName(java.lang.String,boolean,java.lang.ClassLoader)>($r9, 1, $r2);	return $r3
;block_num 3