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

(declare-sort var1281 0)
(declare-sort var2650 0)
(declare-sort var2212 0)
(declare-sort var3634 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getEndTime/665032330 (var1281) Int)
(declare-fun getStartTime/-1874863133 (var1281) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-901862667 (String Int) String)
(declare-fun var2212_buildDetail/-1121687959 (var1281 Int Int Int) var2650)
(declare-fun String_join/1594745010 (String var3634) String)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun cast-from-var2650-to-var3634 (var2650) var3634)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1281 var1281)
(declare-const var775 var1281) ; Statement: r0 := @parameter0: org.apache.dubbo.common.profiler.ProfilerEntry 
(assert (not (= var775 null-var1281)))
(assert true)
(define-const var2875 Int (getEndTime/665032330 var775)) ; Statement: $l1 = virtualinvoke r0.<org.apache.dubbo.common.profiler.ProfilerEntry: long getEndTime()>() 
(assert true)
(define-const var3048 Int (getStartTime/-1874863133 var775)) ; Statement: $l0 = virtualinvoke r0.<org.apache.dubbo.common.profiler.ProfilerEntry: long getStartTime()>() 
(define-const var3728 Int (- var2875 var3048)) ; Statement: l2 = $l1 - $l0 
(define-const var3519 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3519)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3519!1 String)
(assert (= var3519!1 ""))
(assert true)
(define-const var3021 String (append/672562846 var3519!1 "Start time: ")) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Start time: ") 
(declare-const var3519!2 String)
(assert (= var3519!2 (str.++ var3519!1 "Start time: ")))
(assert true)
(define-const var985 Int (getStartTime/-1874863133 var775)) ; Statement: $l3 = virtualinvoke r0.<org.apache.dubbo.common.profiler.ProfilerEntry: long getStartTime()>() 
(assert true)
(define-const var1961 String (append/-901862667 var3021 var985)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l3) 
(declare-const var3021!1 String)
(assert (str.prefixof var3021 var3021!1))
(assert true)
(define-const var2958 String (append/672562846 var1961 "\n")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var1961!1 String)
(assert (= var1961!1 (str.++ var1961 "\n")))
(assert true)
(define-const var3374 Int (getStartTime/-1874863133 var775)) ; Statement: $l4 = virtualinvoke r0.<org.apache.dubbo.common.profiler.ProfilerEntry: long getStartTime()>() 
(define-const var2560 var2650 (var2212_buildDetail/-1121687959 var775 var3374 var3728 0)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.profiler.Profiler: java.util.List buildDetail(org.apache.dubbo.common.profiler.ProfilerEntry,long,long,int)>(r0, $l4, l2, 0) 
(define-const var473 String (String_join/1594745010 (cast-from-String-to-String "\n") (cast-from-var2650-to-var3634 var2560))) ; Statement: $r5 = staticinvoke <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.Iterable)>("\n", $r4) 
(assert true)
(define-const var3619 String (append/672562846 var2958 var473)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2958!1 String)
(assert (= var2958!1 (str.++ var2958 var473)))
(assert true)
(define-const var3797 String (toString/-2075883882 var3619)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {getEndTime/665032330=([org.apache.dubbo.common.profiler.ProfilerEntry], long), getStartTime/-1874863133=([org.apache.dubbo.common.profiler.ProfilerEntry], long), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), var2212_buildDetail/-1121687959=([org.apache.dubbo.common.profiler.ProfilerEntry, long, long, int], java.util.List), String_join/1594745010=([java.lang.CharSequence, java.lang.Iterable], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), cast-from-var2650-to-var3634=([java.util.List], java.lang.Iterable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1281=org.apache.dubbo.common.profiler.ProfilerEntry, var775=r0, var2875=$l1, var3048=$l0, var3728=l2, var3519=$r1, var3021=$r2, var985=$l3, var1961=$r3, var2958=$r6, var3374=$l4, var2650=java.util.List, var2212=org.apache.dubbo.common.profiler.Profiler, var2560=$r4, var3634=java.lang.Iterable, var473=$r5, var3619=$r7, var3797=$r8}
; {org.apache.dubbo.common.profiler.ProfilerEntry=var1281, r0=var775, $l1=var2875, $l0=var3048, l2=var3728, $r1=var3519, $r2=var3021, $l3=var985, $r3=var1961, $r6=var2958, $l4=var3374, java.util.List=var2650, org.apache.dubbo.common.profiler.Profiler=var2212, $r4=var2560, java.lang.Iterable=var3634, $r5=var473, $r7=var3619, $r8=var3797}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.Iterable)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.Iterable)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.profiler.ProfilerEntry;	$l1 = virtualinvoke r0.<org.apache.dubbo.common.profiler.ProfilerEntry: long getEndTime()>();	$l0 = virtualinvoke r0.<org.apache.dubbo.common.profiler.ProfilerEntry: long getStartTime()>();	l2 = $l1 - $l0;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Start time: ");	$l3 = virtualinvoke r0.<org.apache.dubbo.common.profiler.ProfilerEntry: long getStartTime()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l3);	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	$l4 = virtualinvoke r0.<org.apache.dubbo.common.profiler.ProfilerEntry: long getStartTime()>();	$r4 = staticinvoke <org.apache.dubbo.common.profiler.Profiler: java.util.List buildDetail(org.apache.dubbo.common.profiler.ProfilerEntry,long,long,int)>(r0, $l4, l2, 0);	$r5 = staticinvoke <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.Iterable)>("\n", $r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 1